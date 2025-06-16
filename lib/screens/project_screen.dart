// ============================
// project_screen.dart – Elenco contesti (Progetti)
// ============================

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
