// 📄 cervelli_screen.dart
// Schermata di gestione dei cervelli IA disponibili per Lulu.
// Mostra un elenco con nomi dei modelli (es. Llama, Claude, GPT-4...)
// Ogni cervello è accompagnato da uno switch (non ancora funzionante).
// In futuro permetterà l’attivazione/disattivazione dinamica delle IA locali/API.

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
