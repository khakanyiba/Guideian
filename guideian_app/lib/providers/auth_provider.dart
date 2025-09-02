import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userName;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  Future<void> login(String email, String password) async {
    // Simulate login process
    await Future.delayed(const Duration(seconds: 1));
    
    _isLoggedIn = true;
    _userEmail = email;
    _userName = email.split('@')[0];
    
    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', _userName!);
    
    notifyListeners();
  }

  Future<void> signup(String email, String password, String name) async {
    // Simulate signup process
    await Future.delayed(const Duration(seconds: 1));
    
    _isLoggedIn = true;
    _userEmail = email;
    _userName = name;
    
    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', name);
    
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userEmail = null;
    _userName = null;
    
    // Clear local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    _userName = prefs.getString('userName');
    notifyListeners();
  }
}

