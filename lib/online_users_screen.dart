import 'package:flutter/material.dart';

class OnlineUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> onlineUsers = ModalRoute.of(context)!.settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Paikalla olevat käyttäjät'),
      ),
      body: ListView.builder(
        itemCount: onlineUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(onlineUsers[index]),
          );
        },
      ),
    );
  }
}
