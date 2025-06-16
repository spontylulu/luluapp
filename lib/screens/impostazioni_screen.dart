import 'package:flutter/material.dart';
import 'package:luluapp/config/config.dart';

class ImpostazioniScreen extends StatefulWidget {
  const ImpostazioniScreen({super.key});

  @override
  State<ImpostazioniScreen> createState() => _ImpostazioniScreenState();
}

class _ImpostazioniScreenState extends State<ImpostazioniScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _salvataggioEsito;

  @override
  void initState() {
    super.initState();
    _caricaEndpoint();
  }

  Future<void> _caricaEndpoint() async {
    final endpoint = await Config.getEndpoint();
    setState(() {
      _controller.text = endpoint;
    });
  }

  Future<void> _salvaEndpoint() async {
    final nuovoLink = _controller.text.trim();
    if (nuovoLink.isNotEmpty) {
      await Config.setEndpoint(nuovoLink);
      setState(() {
        _salvataggioEsito = '✅ Salvato con successo!';
      });
    } else {
      setState(() {
        _salvataggioEsito = '❌ Inserisci un link valido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni IA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Indirizzo IA (LocalTunnel):',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'https://lulu-ai.loca.lt',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvaEndpoint,
              child: const Text('Salva'),
            ),
            if (_salvataggioEsito != null) ...[
              const SizedBox(height: 12),
              Text(_salvataggioEsito!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
    );
  }
}
