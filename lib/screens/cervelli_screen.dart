// ============================
// cervelli_screen.dart – Elenco cervelli AI attivi
// ============================

import 'package:flutter/material.dart';

class CervelliScreen extends StatelessWidget {
  const CervelliScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cervelli = [
      {"nome": "Llama 3.1", "stato": true},
      {"nome": "Claude", "stato": false},
      {"nome": "GPT-4", "stato": false},
      {"nome": "Mistral", "stato": true},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cervelli AI"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cervelli.length,
        itemBuilder: (context, index) {
          final cervello = cervelli[index];
          return SwitchListTile(
            title: Text(cervello["nome"]),
            value: cervello["stato"],
            onChanged: (bool value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Funzione da implementare")),
              );
            },
          );
        },
      ),
    );
  }
}
