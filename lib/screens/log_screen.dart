// 📄 log_screen.dart
// Schermata che mostra in tempo reale i log di debug dell’app Lulu.
// Utilizza LogService per leggere ed eventualmente svuotare il log corrente.

import 'package:flutter/material.dart';
import 'package:luluapp/core/log_service.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    final logs = LogService.logs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("📜 Log di sistema"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: "Svuota log",
            onPressed: () {
              LogService.clear();
              setState(() {});
            },
          ),
        ],
      ),
      body: logs.isEmpty
          ? const Center(child: Text("Nessun log registrato."))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final msg = logs[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("• $msg", style: const TextStyle(fontSize: 14)),
          );
        },
      ),
    );
  }
}
