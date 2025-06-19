// 📄 main.dart
// Punto di ingresso dell’app Lulu. Imposta il tema e gestisce le rotte principali.

import 'package:flutter/material.dart';
import 'package:luluapp/screens/home_screen.dart';
import 'package:luluapp/screens/hub_screen.dart';
import 'package:luluapp/screens/webview_screen.dart';
import 'package:luluapp/screens/project_screen.dart';
import 'package:luluapp/screens/cervelli_screen.dart';
import 'package:luluapp/screens/cronologia_screen.dart';
import 'package:luluapp/screens/impostazioni_screen.dart';
import 'package:luluapp/screens/debug_screen.dart';
import 'package:luluapp/screens/log_screen.dart'; // ✅ Aggiunto

void main() {
  runApp(const LuluApp());
}

class LuluApp extends StatelessWidget {
  const LuluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lulu',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/hub': (_) => const HubScreen(),
        '/webview': (_) => const WebviewScreen(),
        '/progetti': (_) => const ProjectScreen(),
        '/cervelli': (_) => const CervelliScreen(),
        '/cronologia': (_) => const CronologiaScreen(),
        '/impostazioni': (_) => const ImpostazioniScreen(),
        '/debug': (_) => const DebugScreen(),
        '/log': (_) => const LogScreen(), // ✅ Aggiunto
      },
    );
  }
}
