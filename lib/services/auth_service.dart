import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _emailKey = 'user_email';

  static Future<void> init() async {}

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) != null;
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
  }

  static bool isAdmin() {
    throw UnimplementedError();
  }

  static Future<void> login(String username, String password) async {
    if (username == 'admin' && password == 'admin') {
      throw UnimplementedError();
    } else if (username == 'user' && password == 'user') {
      throw UnimplementedError();
    } else {
      throw Exception('Identifiants invalides');
    }
  }

  static Future<void> register(String username, String password) async {
    throw UnimplementedError();
  }
}
