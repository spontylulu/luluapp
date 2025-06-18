// 📄 webview_screen.dart
// Schermata WebView per accedere alla versione web di Lulu come fallback.
// Carica l’interfaccia pubblicata su Render.com o altro endpoint esterno.
// Utile per accedere alla versione remota del server IA da dispositivi mobili o browser embedded.

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse('https://lulu-server.onrender.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lulu (Web)"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
