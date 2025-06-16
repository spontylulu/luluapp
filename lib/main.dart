import 'package:flutter/material.dart';
import 'package:luluapp/screens/home_screen.dart';
import 'package:luluapp/core/immersive_mode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ImmersiveMode.enable(); // Attiva modalità immersiva
  runApp(const LuluApp());
}

class LuluApp extends StatelessWidget {
  const LuluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lulu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}
