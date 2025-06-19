// 📄 ai_manager.dart
// Gestisce l’invio dei prompt all’IA e il ping dell’endpoint.
// Mostra solo gli errori critici (proxy LLaMA o memoria) nel log.

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:luluapp/config/config.dart';
import 'package:luluapp/core/identity_manager.dart';
import 'package:luluapp/core/log_service.dart';

class AIManager {
  static const _path = "/api/chat";

  /// Invia un messaggio all’IA e ritorna la risposta come stringa
  static Future<String> askLulu(String prompt) async {
    final baseUrl = await Config.getEndpoint();
    final url = Uri.parse('$baseUrl$_path');

    try {
      final identity = await IdentityManager.loadIdentity();
      final systemMessage = {
        "role": "system",
        "content": "Tu sei ${identity.nome}, ${identity.ruolo}. Il tuo tono deve essere ${identity.tono}."
      };

      final userMessage = {
        "role": "user",
        "content": prompt
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "messages": [
            systemMessage,
            userMessage,
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['message']['content'] ?? '(nessuna risposta)';
        return reply;
      } else {
        LogService.add("❌ Errore proxy LLaMA [${response.statusCode}]: ${response.reasonPhrase}");
        return "(Errore ${response.statusCode})";
      }
    } on SocketException catch (e) {
      LogService.add("❌ Connessione rifiutata dal proxy LLaMA: $e");
      return "(Errore di connessione)";
    } on TimeoutException catch (e) {
      LogService.add("❌ Timeout nella risposta dal proxy LLaMA: $e");
      return "(Timeout)";
    } catch (e) {
      LogService.add("❌ Errore imprevisto durante la chiamata all’IA: $e");
      return "(Errore generico)";
    }
  }

  /// Verifica se l’endpoint IA risponde
  static Future<bool> ping() async {
    final baseUrl = await Config.getEndpoint();
    final url = Uri.parse('$baseUrl/test');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } on SocketException catch (e) {
      LogService.add("❌ Errore ping: impossibile raggiungere il proxy LLaMA ($e)");
      return false;
    } on TimeoutException catch (e) {
      LogService.add("❌ Errore ping: timeout durante la connessione ($e)");
      return false;
    } catch (e) {
      LogService.add("❌ Errore ping: problema sconosciuto ($e)");
      return false;
    }
  }
}
