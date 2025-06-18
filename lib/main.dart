// 📄 main.dart
// Punto di ingresso principale dell’app Lulu.
// - Inizializza Flutter e carica l’identità da identity_manager.dart
// - Lancia l’app con tema scuro Material 3
// - Definisce tutte le rotte per navigare tra schermate

import 'package:flutter/material.dart';
import 'package:luluapp/screens/home_screen.dart';
import 'core/identity_manager.dart';
import 'package:luluapp/screens/hub_screen.dart';
import 'package:luluapp/screens/project_screen.dart';
import 'package:luluapp/screens/cervelli_screen.dart';
import 'package:luluapp/screens/cronologia_screen.dart';
import 'package:luluapp/screens/impostazioni_screen.dart';
import 'package:luluapp/screens/webview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carica o crea l'identità persistente di Lulu
  final identita = await IdentityManager.loadIdentity();
  print("👤 Identità caricata: ${identita.nome} - ${identita.ruolo}");

  runApp(const LuluApp());
}

class LuluApp extends StatelessWidget {
  const LuluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lulu',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/hub': (context) => const HubScreen(),
        '/progetti': (context) => const ProjectScreen(),
        '/cervelli': (context) => const CervelliScreen(),
        '/cronologia': (context) => const CronologiaScreen(),
        '/impostazioni': (context) => const ImpostazioniScreen(),
        '/webview': (context) => const WebviewScreen(),
      },
    );
  }
}
