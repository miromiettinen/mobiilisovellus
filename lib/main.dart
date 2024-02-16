import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'login_page.dart';
import 'chat_screen.dart';
import 'online_users_screen.dart';
import 'register_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.purple[200],
        hintColor: Colors.purpleAccent[200],
        appBarTheme: AppBarTheme(
          color: Colors.purple[200],
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
        ),
        colorScheme: ColorScheme.light(
          secondary: const Color.fromARGB(255, 194, 48, 219),
        ).copyWith(background: Colors.purple[50]),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/chat': (context) => ChatScreen(),
        '/online': (context) => OnlineUsersScreen(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
