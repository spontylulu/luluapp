import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:luluapp/config/config.dart';

class AIManager {
  static const _path = "/api/chat";

  /// Invia un messaggio all’IA e ritorna la risposta come stringa
  static Future<String> askLulu(String prompt) async {
    final baseUrl = await Config.getEndpoint();
    final url = Uri.parse('$baseUrl$_path');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "messages": [
            {"role": "user", "content": prompt}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message']['content'] ?? '(nessuna risposta)';
      } else {
        return "(Errore ${response.statusCode})";
      }
    } catch (e) {
      return "(Errore di rete)";
    }
  }

  /// Verifica se l’endpoint IA risponde
  static Future<bool> ping() async {
    final baseUrl = await Config.getEndpoint();
    final url = Uri.parse('$baseUrl/test');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
