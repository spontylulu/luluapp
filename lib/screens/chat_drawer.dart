// 📄 chat_drawer.dart
// Menu laterale principale di Lulu, dedicato alla gestione delle chat.
// Contiene:
// - Il logo e nome "Lulu" in alto (cliccabile → apre l’Hub di sistema)
// - Il pulsante “+ Nuova chat”
// - L’elenco delle chat esistenti, ordinate per ultima modifica (più recente in alto)
// Quando si seleziona una chat, chiama il callback fornito (`onChatSelected`).

import 'package:flutter/material.dart';

class ChatDrawer extends StatelessWidget {
  final List<String> chatList;
  final void Function(String chatName) onChatSelected;
  final VoidCallback onNewChat;
  final VoidCallback onLuluTap;

  const ChatDrawer({
    Key? key,
    required this.chatList,
    required this.onChatSelected,
    required this.onNewChat,
    required this.onLuluTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌕 Logo + Lulu (cliccabile)
            InkWell(
              onTap: () {
                Navigator.pop(context); // chiude il drawer
                Navigator.pushNamed(context, '/hub');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.psychology_alt)),
                    const SizedBox(width: 12),
                    Text(
                      "Lulu",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),

            const Divider(),

            // ➕ Nuova chat
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Nuova chat"),
              onTap: onNewChat,
            ),

            const Divider(),

            // 📜 Lista chat ordinate per data (già ordinate dal chiamante)
            Expanded(
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final chatName = chatList[index];
                  return ListTile(
                    leading: const Icon(Icons.chat_bubble_outline),
                    title: Text(chatName),
                    onTap: () => onChatSelected(chatName),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
