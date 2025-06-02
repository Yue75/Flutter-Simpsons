// services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool isLoggedIn() {
    return _prefs?.getBool('loggedIn') ?? false;
  }

  static bool isAdmin() {
    return _prefs?.getString('role') == 'admin';
  }

  static Future<void> login(String username, String password) async {
    // Pour la démo, on simule deux utilisateurs
    if (username == 'admin' && password == 'admin') {
      await _prefs?.setBool('loggedIn', true);
      await _prefs?.setString('role', 'admin');
    } else if (username == 'user' && password == 'user') {
      await _prefs?.setBool('loggedIn', true);
      await _prefs?.setString('role', 'user');
    } else {
      throw Exception('Identifiants invalides');
    }
  }

  static Future<void> logout() async {
    await _prefs?.clear();
  }

  static Future<void> register(String username, String password) async {
    // Cette méthode est fictive pour la démo
    await _prefs?.setBool('loggedIn', true);
    await _prefs?.setString('role', 'user');
  }
}
