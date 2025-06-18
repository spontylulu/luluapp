import 'package:flutter/material.dart';
import 'package:luluapp/screens/home_screen.dart';
import 'core/identity_manager.dart';

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
    );
  }
}
