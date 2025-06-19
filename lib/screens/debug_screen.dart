// 📄 debug_screen.dart
// Schermata di debug per mostrare i log interni dell'app.
// Visualizza i messaggi salvati tramite LogService, con scroll verticale e pulsante di pulizia.

import 'package:flutter/material.dart';
import 'package:luluapp/core/log_service.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = LogService.logs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("🛠️ Log di Debug"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Pulisci log",
            onPressed: () {
              LogService.clear();
              (context as Element).markNeedsBuild(); // Forza refresh
            },
          )
        ],
      ),
      body: logs.isEmpty
          ? const Center(child: Text("Nessun log registrato."))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return Text("• $log", style: const TextStyle(fontSize: 14));
        },
      ),
    );
  }
}
