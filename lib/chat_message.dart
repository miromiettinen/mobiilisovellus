import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String username;
  final String text;

  ChatMessage({required this.username, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(username[0]),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple, // Tumman violetti pohjaväri
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0), // Valkoinen tekstiväri
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (text.isNotEmpty) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white, // Valkoinen tekstiväri
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
