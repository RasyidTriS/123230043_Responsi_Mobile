import 'package:shared_preferences/shared_preferences.dart';

/// Service untuk manage authentication
class AuthService {
  static const String _usernameKey = 'username';
  static const String _isLoggedInKey = 'isLoggedIn';

  /// Check apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Dapatkan username dari session
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// Login dengan username dan password
  /// Simpan ke SharedPreferences
  static Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Logout - hapus session
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_isLoggedInKey);
  }
}
