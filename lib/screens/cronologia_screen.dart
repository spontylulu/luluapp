// ============================
// cronologia_screen.dart – Cronologia interazioni utente
// ============================

import 'package:flutter/material.dart';

class CronologiaScreen extends StatelessWidget {
  const CronologiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> log = [
      "🗨️ Tu: Che tempo fa oggi?",
      "🤖 Lulu: Sole e 24°C a Milano.",
      "🗨️ Tu: Elenca i miei progetti attivi.",
      "🤖 Lulu: Hai 3 progetti attivi.",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cronologia"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: log.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(log[index].startsWith("🗨️") ? Icons.person : Icons.smart_toy),
            title: Text(log[index]),
          );
        },
      ),
    );
  }
}
