import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('username');
  }
}