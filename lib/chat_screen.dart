import 'package:flutter/material.dart';
import 'package:harkka1/chat_message.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_state.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text, AppState appState) {
  _textController.clear();
  ChatMessage message = ChatMessage(
    username: appState.loggedInUsername ?? 'Tuntematon käyttäjä',
    text: text,
  );
  setState(() {
    _messages.insert(0, message);
  });

  // Tallennetaan viesti laitteelle
  saveMessageLocally(text);

  // Lisätään online-käyttäjätila
  appState.addOnlineUser(appState.loggedInUsername ?? 'Tuntematon käyttäjä');
}


  Widget _buildTextComposer(AppState appState) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: (text) => _handleSubmitted(text, appState),
              decoration: InputDecoration(
                hintText: 'Kirjoita viesti...',
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary),
            onPressed: () => _handleSubmitted(_textController.text, appState),
          ),
        ],
      ),
    );
  }

  void _openOnlineUsers(BuildContext context, AppState appState) {
    Navigator.pushNamed(
      context,
      '/online',
      arguments: appState.onlineUsers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatti'),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () => _openOnlineUsers(context, Provider.of<AppState>(context, listen: false)),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Consumer<AppState>(
              builder: (context, appState, _) => _buildTextComposer(appState),
            ),
          ),
        ],
      ),
    );
  }

  // Tallennetaan viesti paikallisesti
  void saveMessageLocally(String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messages = prefs.getStringList('messages');
    if (messages == null) {
      messages = [];
    }
    messages.add(message);
    prefs.setStringList('messages', messages);
  }
}