// 📄 chat_memory_manager.dart
// Gestione della memoria delle chat in Lulu.
// - Salva ogni messaggio in file giornalieri per sessione (es. chat_ricette/2025-06-19.json)
// - Registra metadata nel file index.json per ogni chat creata
// - Permette il caricamento e salvataggio di messaggi (utente e IA)
// - Mostra solo errori critici in caso di problemi di scrittura o lettura

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:luluapp/core/log_service.dart';

class ChatMessage {
  final String mittente;
  final String contenuto;
  final DateTime timestamp;
  final List<String> hashtags;

  ChatMessage({
    required this.mittente,
    required this.contenuto,
    required this.timestamp,
    this.hashtags = const [],
  });

  Map<String, dynamic> toJson() => {
    'mittente': mittente,
    'contenuto': contenuto,
    'timestamp': timestamp.toIso8601String(),
    'hashtags': hashtags,
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      mittente: json['mittente'],
      contenuto: json['contenuto'],
      timestamp: DateTime.parse(json['timestamp']),
      hashtags: List<String>.from(json['hashtags'] ?? []),
    );
  }
}

class ChatIndexEntry {
  final String nome;
  final DateTime creata;
  DateTime ultimoAccesso;

  ChatIndexEntry({
    required this.nome,
    required this.creata,
    required this.ultimoAccesso,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'creata': creata.toIso8601String(),
    'ultimoAccesso': ultimoAccesso.toIso8601String(),
  };

  factory ChatIndexEntry.fromJson(Map<String, dynamic> json) {
    return ChatIndexEntry(
      nome: json['nome'],
      creata: DateTime.parse(json['creata']),
      ultimoAccesso: DateTime.parse(json['ultimoAccesso']),
    );
  }
}

class ChatMemoryManager {
  static Future<String> _getBasePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/memoria/cronologia';
  }

  static Future<String> _getTodayFilePath(String sessione) async {
    final basePath = await _getBasePath();
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final dir = Directory('$basePath/$sessione');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return '${dir.path}/$date.json';
  }

  static Future<void> appendMessage(String sessione, ChatMessage message) async {
    try {
      final filePath = await _getTodayFilePath(sessione);
      final file = File(filePath);
      List<ChatMessage> history = [];

      if (await file.exists()) {
        final content = await file.readAsString();
        history = List<Map<String, dynamic>>.from(jsonDecode(content))
            .map((msg) => ChatMessage.fromJson(msg))
            .toList();
      }

      history.add(message);
      final updatedJson = jsonEncode(history.map((m) => m.toJson()).toList());
      await file.writeAsString(updatedJson, flush: true);
      await updateIndex(sessione);
    } catch (e) {
      LogService.add("❌ Errore scrittura memoria (appendMessage) [$sessione]: $e");
    }
  }

  static Future<List<ChatMessage>> loadMessages(String sessione) async {
    try {
      final filePath = await _getTodayFilePath(sessione);
      final file = File(filePath);
      if (!await file.exists()) {
        return [];
      }

      final content = await file.readAsString();
      await updateIndex(sessione);
      final messages = List<Map<String, dynamic>>.from(jsonDecode(content))
          .map((msg) => ChatMessage.fromJson(msg))
          .toList();

      return messages;
    } catch (e) {
      LogService.add("❌ Errore lettura memoria (loadMessages) [$sessione]: $e");
      return [];
    }
  }

  static Future<List<String>> listSessions() async {
    final basePath = await _getBasePath();
    final dir = Directory(basePath);
    if (!await dir.exists()) return [];

    final dirs = await dir.list().toList();
    return dirs
        .whereType<Directory>()
        .map((d) => d.path.split(Platform.pathSeparator).last)
        .toList();
  }

  static Future<File> _getIndexFile() async {
    final basePath = await _getBasePath();
    return File('$basePath/index.json');
  }

  static Future<void> addToIndex(String sessione) async {
    try {
      final file = await _getIndexFile();
      Map<String, dynamic> index = {};

      if (await file.exists()) {
        index = jsonDecode(await file.readAsString());
      }

      if (!index.containsKey(sessione)) {
        index[sessione] = ChatIndexEntry(
          nome: sessione,
          creata: DateTime.now(),
          ultimoAccesso: DateTime.now(),
        ).toJson();
        await file.writeAsString(jsonEncode(index), flush: true);
      }
    } catch (e) {
      LogService.add("❌ Errore aggiornamento indice (addToIndex) [$sessione]: $e");
    }
  }

  static Future<void> updateIndex(String sessione) async {
    try {
      final file = await _getIndexFile();
      Map<String, dynamic> index = {};

      if (await file.exists()) {
        index = jsonDecode(await file.readAsString());
      }

      final now = DateTime.now();

      index[sessione] = ChatIndexEntry(
        nome: sessione,
        creata: index[sessione] != null
            ? DateTime.parse(index[sessione]['creata'])
            : now,
        ultimoAccesso: now,
      ).toJson();

      await file.writeAsString(jsonEncode(index), flush: true);
    } catch (e) {
      LogService.add("❌ Errore aggiornamento indice (updateIndex) [$sessione]: $e");
    }
  }

  static Future<List<ChatIndexEntry>> getIndex() async {
    try {
      final file = await _getIndexFile();
      if (!await file.exists()) return [];

      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;
      final list = data.values
          .map((e) => ChatIndexEntry.fromJson(e as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => b.ultimoAccesso.compareTo(a.ultimoAccesso));

      return list;
    } catch (e) {
      LogService.add("❌ Errore lettura indice memoria (getIndex): $e");
      return [];
    }
  }
}
