import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  String? loggedInUsername; //Lisätty käyttäjänimi
  List<String> onlineUsers = [];

  void addOnlineUser(String user) {
    onlineUsers.add(user);
    notifyListeners();
  }

  void removeOnlineUser(String user) {
    onlineUsers.remove(user);
    notifyListeners();
  }
  
  void setLoggedInUsername(String username) {
    loggedInUsername = username;
    notifyListeners();
  }

  Future<bool> registerUser(String username, String password, String email, String name) async {
    // Tarkistaa, onko käyttäjä jo rekisteröity
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(username)) {
      return false; // Käyttäjä on jo rekisteröity
    }

    // Käyttäjän tiedot tallennetaan paikallisesti
    prefs.setStringList(username, [password, email, name]);
    loggedInUsername = username;
    notifyListeners();
    return true;
  }

  Future<bool> loginUser(String username, String password) async {
    // Tarkista käyttäjän tiedot paikallisesti
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userData = prefs.getStringList(username);
    if (userData != null && userData.isNotEmpty && userData[0] == password) {
      loggedInUsername = username;
      notifyListeners();
      return true; // Kirjautuminen onnistui
    }
    return false; // Kirjautuminen epäonnistui
  }
}