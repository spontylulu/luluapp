// 📄 hub_screen.dart
// Schermata centrale del sistema. Raggiungibile cliccando su “Lulu” nel menu laterale.
// Contiene i collegamenti a tutte le funzioni generali:
// - Home, Progetti, Cervelli IA, Cronologia, Webview, Impostazioni generali
// - Log di sistema, Debug IA

import 'package:flutter/material.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hub di sistema'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.folder_special),
            title: const Text("Progetti"),
            onTap: () {
              Navigator.pushNamed(context, '/progetti');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.psychology_alt_outlined),
            title: const Text("Cervelli AI"),
            onTap: () {
              Navigator.pushNamed(context, '/cervelli');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Cronologia"),
            onTap: () {
              Navigator.pushNamed(context, '/cronologia');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Lulu Web"),
            onTap: () {
              Navigator.pushNamed(context, '/webview');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Impostazioni generali"),
            onTap: () {
              Navigator.pushNamed(context, '/impostazioni');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text("Log di sistema"),
            onTap: () {
              Navigator.pushNamed(context, '/log');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text("Debug IA"),
            onTap: () {
              Navigator.pushNamed(context, '/debug');
            },
          ),
        ],
      ),
    );
  }
}
