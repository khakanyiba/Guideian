import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userName;
  String? _userId;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get userId => _userId;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      _setLoading(true);
      
      // Simulate login process
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, accept any email/password combination
      if (email.isNotEmpty && password.isNotEmpty) {
        _isLoggedIn = true;
        _userEmail = email;
        _userName = email.split('@')[0];
        _userId = 'demo_user_${DateTime.now().millisecondsSinceEpoch}';
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', _userName!);
        await prefs.setString('userId', _userId!);
        
        notifyListeners();
        return null; // Success
      }
      return 'Please enter email and password';
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signup(String email, String password, String name, String grade) async {
    try {
      _setLoading(true);
      
      // Simulate signup process
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, accept any valid input
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        _isLoggedIn = true;
        _userEmail = email;
        _userName = name;
        _userId = 'demo_user_${DateTime.now().millisecondsSinceEpoch}';
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', name);
        await prefs.setString('userId', _userId!);
        
        notifyListeners();
        return null; // Success
      }
      return 'Please fill in all required fields';
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);
      
      // Simulate Google sign-in process
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoggedIn = true;
      _userEmail = 'google_user@example.com';
      _userName = 'Google User';
      _userId = 'google_user_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', _userEmail!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userId', _userId!);
      
      notifyListeners();
      return null; // Success
    } catch (e) {
      _setLoading(false);
      return 'Google sign-in error: $e';
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      _setLoading(true);
      
      // Simulate Facebook sign-in process
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoggedIn = true;
      _userEmail = 'facebook_user@example.com';
      _userName = 'Facebook User';
      _userId = 'facebook_user_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', _userEmail!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userId', _userId!);
      
      notifyListeners();
      return null; // Success
    } catch (e) {
      _setLoading(false);
      return 'Facebook sign-in error: $e';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      _setLoading(true);
      
      // Simulate password reset process
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isNotEmpty) {
        _setLoading(false);
        return null; // Success
      }
      return 'Please enter a valid email address';
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<void> logout() async {
    try {
      // Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('userEmail');
      await prefs.remove('userName');
      await prefs.remove('userId');
      
      _isLoggedIn = false;
      _userEmail = null;
      _userName = null;
      _userId = null;
      notifyListeners();
    } catch (e) {
      print('Logout error: $e');
    }
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    _userName = prefs.getString('userName');
    _userId = prefs.getString('userId');
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    if (_userId == null) return null;
    
    try {
      // Return demo user data
      return {
        'name': _userName,
        'email': _userEmail,
        'userId': _userId,
        'createdAt': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }
}