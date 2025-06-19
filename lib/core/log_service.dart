// 📄 log_service.dart
// Servizio centralizzato per raccogliere e visualizzare log interni all'app

class LogService {
  static final List<String> _logs = [];

  static void add(String message) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    _logs.insert(0, "[$timestamp] $message");
  }

  static List<String> get logs => List.unmodifiable(_logs);

  static void clear() {
    _logs.clear();
  }
}
