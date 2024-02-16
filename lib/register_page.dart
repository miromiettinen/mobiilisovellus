import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isValidEmail(String email) {
    // Tarkista sähköpostin muoto säännöllisen lausekkeen avulla
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  Future<void> _handleRegistration(BuildContext context, AppState appState) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim();
    String name = _nameController.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Täytä kaikki tiedot.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tarkista sähköpostin muotoilu.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Käyttäjän rekisteröiminen
      bool registrationSuccess = await appState.registerUser(username, password, email, name);

      if (registrationSuccess) {
        // Siirretään käyttäjä kirjautumissivulle rekisteröitymisen jälkeen
        Navigator.pushNamed(
          context,
          '/',
        );

        // Ilmoitus onnistuneesta rekisteröitymisestä
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rekisteröityminen onnistui! Voit nyt kirjautua sisään.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Käyttäjänimi on jo käytössä.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekisteröidy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Käyttäjänimi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Salasana',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Sähköposti',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nimi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _handleRegistration(context, Provider.of<AppState>(context, listen: false)),
              child: Text('Rekisteröidy'),
            ),
          ],
        ),
      ),
    );
  }
}
