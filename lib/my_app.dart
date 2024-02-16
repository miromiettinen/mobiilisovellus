import 'package:flutter/material.dart';
import 'login_page.dart';
import 'chat_screen.dart';
import 'online_users_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.purple[200], // Vaalean violetti pääväri
        hintColor: Colors.purpleAccent[200], // Vaalean violetti korostusväri
        appBarTheme: AppBarTheme(
          color: Colors.purple[200], // Vaalean violetti AppBar
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 16.0,
            color: Colors.black54,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ), colorScheme: ColorScheme.light(
          secondary: const Color.fromARGB(255, 194, 48, 219), // Vaalean violetti toissijainen väri
        ).copyWith(background: Colors.purple[50]), // Vaalean violetti taustaväri
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/chat': (context) => ChatScreen(),
        '/online': (context) => OnlineUsersScreen(),
      },
    );
  }
}