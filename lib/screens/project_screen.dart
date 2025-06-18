// 📄 project_screen.dart
// Schermata dei progetti attivi o contesti tematici dell’utente.
// Elenca i macro-ambiti come “Lavoro”, “Arduino”, “Scrittura”, ecc.
// Ogni progetto è selezionabile, ma per ora mostra solo un messaggio fittizio.
// In futuro aprirà una schermata specifica o filtrerà la memoria per contesto.

import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> progetti = [
      "📘 Lavoro",
      "🛠️ Hobby – Arduino",
      "📚 Scrittura Libro",
      "🎮 Gioco da tavolo",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Progetti"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: progetti.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: Text(progetti[index]),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Apertura: ${progetti[index]}")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
