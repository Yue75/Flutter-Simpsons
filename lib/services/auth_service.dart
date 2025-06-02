import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthService {
  static const String _userKey = 'user';
  static SharedPreferences? _prefs;

  // Initialiser SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Vérifier si l'utilisateur est connecté
  static bool isLoggedIn() {
    return _prefs?.getString(_userKey) != null;
  }

  // Récupérer l'utilisateur connecté
  static User? getCurrentUser() {
    final userJson = _prefs?.getString(_userKey);
    if (userJson == null) return null;
    return User.fromJson(json.decode(userJson));
  }

  // Connecter l'utilisateur
  static Future<void> login(User user) async {
    await _prefs?.setString(_userKey, json.encode(user.toJson()));
  }

  // Déconnecter l'utilisateur
  static Future<void> logout() async {
    await _prefs?.remove(_userKey);
  }
}
