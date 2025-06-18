import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Identity {
  String nome;
  String ruolo;
  String tono;

  Identity({
    required this.nome,
    required this.ruolo,
    required this.tono,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      nome: json['nome'] ?? '',
      ruolo: json['ruolo'] ?? '',
      tono: json['tono'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'ruolo': ruolo,
      'tono': tono,
    };
  }
}

class IdentityManager {
  static Future<String> _getIdentityFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    final memoriaDir = Directory('${dir.path}/memoria');

    if (!await memoriaDir.exists()) {
      await memoriaDir.create(recursive: true);
    }

    return '${memoriaDir.path}/identita.json';
  }

  static Future<Identity> loadIdentity() async {
    final path = await _getIdentityFilePath();
    final file = File(path);

    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        final jsonData = jsonDecode(content);
        return Identity.fromJson(jsonData);
      } catch (e) {
        print('⚠️ Errore nel parsing di identita.json: $e');
      }
    }

    final defaultIdentity = Identity(
      nome: 'Lulu',
      ruolo: 'Assistente personale intelligente',
      tono: 'Professionale e amichevole',
    );
    await saveIdentity(defaultIdentity);
    return defaultIdentity;
  }

  static Future<void> saveIdentity(Identity identity) async {
    final path = await _getIdentityFilePath();
    final file = File(path);
    await file.writeAsString(jsonEncode(identity.toJson()), flush: true);
  }

  static Future<void> updateField(String key, String value) async {
    final identity = await loadIdentity();

    switch (key) {
      case 'nome':
        identity.nome = value;
        break;
      case 'ruolo':
        identity.ruolo = value;
        break;
      case 'tono':
        identity.tono = value;
        break;
      default:
        print('⚠️ Campo non valido per l’identità: $key');
        return;
    }

    await saveIdentity(identity);
  }
}
