// 📄 home_screen.dart
// Schermata principale dell’app Lulu.
// Carica dinamicamente le chat da index.json tramite ChatMemoryManager
// Ordina per ultimo utilizzo, mostra conversazione corrente, salva automaticamente ogni messaggio.
// Integra SafeArea per evitare che il campo testo finisca sotto i tasti di sistema Android.

import 'package:flutter/material.dart';
import 'package:luluapp/core/ai_manager.dart';
import 'package:luluapp/core/chat_memory_manager.dart';
import 'package:luluapp/screens/chat_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> messages = [];
  List<ChatIndexEntry> chatIndex = [];
  bool _isSending = false;
  String currentChat = "";

  @override
  void initState() {
    super.initState();
    _caricaChatRecenti();
  }

  Future<void> _caricaChatRecenti() async {
    final index = await ChatMemoryManager.getIndex();
    setState(() {
      chatIndex = index;
      currentChat = index.isNotEmpty ? index.first.nome : "chat_default";
    });
    _loadMessages(currentChat);
  }

  Future<void> _loadMessages(String chatName) async {
    final history = await ChatMemoryManager.loadMessages(chatName);
    setState(() {
      messages.clear();
      messages.addAll(history);
    });
  }

  Future<void> _salvaMessaggio(String role, String contenuto) async {
    final msg = ChatMessage(
      mittente: role,
      contenuto: contenuto,
      timestamp: DateTime.now(),
    );
    await ChatMemoryManager.appendMessage(currentChat, msg);
    setState(() => messages.add(msg));
  }

  Future<void> _askLulu(String prompt) async {
    setState(() => _isSending = true);
    await _salvaMessaggio("utente", prompt);

    final reply = await AIManager.askLulu(prompt);
    await _salvaMessaggio("ia", reply);

    setState(() => _isSending = false);
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    _askLulu(text);
  }

  void _nuovaChat() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameCtrl = TextEditingController();
        return AlertDialog(
          title: const Text("Nuova chat"),
          content: TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(hintText: "Nome chat"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                if (name.isNotEmpty) {
                  await ChatMemoryManager.addToIndex(name);
                  setState(() {
                    currentChat = name;
                    messages.clear();
                  });
                  _caricaChatRecenti();
                  Navigator.pop(context);
                }
              },
              child: const Text("Crea"),
            ),
          ],
        );
      },
    );
  }

  void _selezionaChat(String nome) async {
    setState(() {
      currentChat = nome;
      messages.clear();
    });
    await _loadMessages(nome);
    await _caricaChatRecenti();
  }

  void _vaiAllHub() {
    Navigator.pushNamed(context, "/hub");
  }

  @override
  Widget build(BuildContext context) {
    final chatNames = chatIndex.map((e) => e.nome).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("💬 $currentChat"),
      ),
      drawer: ChatDrawer(
        chatList: chatNames,
        onNewChat: _nuovaChat,
        onChatSelected: _selezionaChat,
        onLuluTap: _vaiAllHub,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg.mittente == "utente";
                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueGrey : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.contenuto,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            bottom: true,
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: "Scrivi a Lulu...",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: _isSending
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: _isSending ? null : _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
