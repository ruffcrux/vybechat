import 'package:flutter/material.dart';

void main() {
  runApp(const VybeChatApp());
}

class VybeChatApp extends StatelessWidget {
  const VybeChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VybeChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatListScreen(),
    );
  }
}

class Chat {
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  Chat(this.name, this.lastMessage, this.time, this.avatar);
}

final chats = [
  Chat('Vybe Squad', 'Yo! Party tonight? 🔥', '20:29', 'VS'),
  Chat('Mama', 'Call me when you reach', '19:45', 'M'),
  Chat('Brian', 'Bro that beat is crazy', '18:12', 'B'),
  Chat('Sarah', 'See you tomorrow 💜', '17:02', 'S'),
  Chat('Nairobi Vibes', 'New event this Friday!', '15:30', 'NV'),
];

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VybeChat', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: const [Icon(Icons.search), SizedBox(width: 16), Icon(Icons.more_vert), SizedBox(width: 8)],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              child: Text(chat.avatar),
            ),
            title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(chat.lastMessage),
            trailing: Text(chat.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(chat: chat)));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({super.key, required this.chat});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final messages = [
    {'text': 'Yo! Welcome to VybeChat 🔥', 'me': false},
    {'text': 'This is looking clean!', 'me': true},
    {'text': 'Let’s vybe 💜', 'me': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final m = messages[i];
                final isMe = m['me'] == true;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.deepPurple : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(m['text'] as String, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Type a vybe...', border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24)))),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    setState(() {
                      messages.add({'text': controller.text, 'me': true});
                      controller.clear();
                    });
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
