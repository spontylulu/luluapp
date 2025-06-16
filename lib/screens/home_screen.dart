import 'package:flutter/material.dart';
import 'package:luluapp/screens/project_screen.dart';
import 'package:luluapp/screens/cervelli_screen.dart';
import 'package:luluapp/screens/cronologia_screen.dart';
import 'package:luluapp/screens/impostazioni_screen.dart';
import 'package:luluapp/screens/webview_screen.dart';
import 'package:luluapp/core/ai_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> messages = [
    "Tu: Ciao Lulu!",
    "Lulu: Ciao! Come posso aiutarti oggi?",
  ];
  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;

  Future<void> _askLulu(String prompt) async {
    setState(() {
      _isSending = true;
    });

    final reply = await AIManager.askLulu(prompt);

    setState(() {
      messages.add("Lulu: $reply");
      _isSending = false;
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add("Tu: $text");
      });
      _controller.clear();
      _askLulu(text);
    }
  }

  void _onMenuItemTap(String label) {
    Navigator.pop(context);
    switch (label) {
      case 'Progetti':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjectScreen()));
        break;
      case 'Cervelli AI':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CervelliScreen()));
        break;
      case 'Cronologia':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CronologiaScreen()));
        break;
      case 'Impostazioni':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ImpostazioniScreen()));
        break;
      case 'Lulu Web':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const WebviewScreen()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lulu'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ...[
              'Home',
              'Progetti',
              'Cervelli AI',
              'Cronologia',
              'Impostazioni',
              'Lulu Web',
            ].map((label) => ListTile(
              title: Text(label),
              onTap: () => _onMenuItemTap(label),
            )),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (_, index) => Text(messages[index]),
              ),
            ),
            if (_isSending)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Scrivi un messaggio...',
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isSending ? null : _sendMessage,
                    child: const Text('Invia'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
