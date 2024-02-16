import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin(BuildContext context, AppState appState) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Syötä käyttäjänimi ja salasana.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      bool loginSuccess = await appState.loginUser(username, password);

    if (loginSuccess) {
      // Siirrä käyttäjä chat-sivulle kirjautumisen jälkeen
      Navigator.pushNamed(
        context,
        '/chat',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Väärä käyttäjänimi tai salasana.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
  void _navigateToRegisterPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/register',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tervetuloa takaisin!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Käyttäjänimi',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Salasana',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _handleLogin(context, Provider.of<AppState>(context, listen: false)),
              child: Text('Kirjaudu'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Ohjaa käyttäjä rekisteröitymissivulle
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Etkö ole vielä jäsen? Rekisteröidy täällä.'),
            ),
          ],
        ),
      ),
    );
  }
}