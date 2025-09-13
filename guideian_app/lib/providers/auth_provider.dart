import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userName;
  String? _userId;
  String? _idToken;

  // Firebase configuration
  static const String _apiKey = 'AIzaSyB41Go0wudzjur1xcPO4t-_gk9fGYccgg4';
  static const String _databaseUrl = 'https://guideian-b5eb4-default-rtdb.firebaseio.com';

  // Google Sign-in configuration
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '723263641111-cf6ee50tgv17gsi1c6v4ds4v9u8jd2kn.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get userId => _userId;

  AuthProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    _userName = prefs.getString('userName');
    _userId = prefs.getString('userId');
    _idToken = prefs.getString('idToken');
    notifyListeners();
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    if (_userEmail != null) await prefs.setString('userEmail', _userEmail!);
    if (_userName != null) await prefs.setString('userName', _userName!);
    if (_userId != null) await prefs.setString('userId', _userId!);
    if (_idToken != null) await prefs.setString('idToken', _idToken!);
  }

  Future<String?> login(String email, String password) async {
    try {
      print('Starting login for: $email');
      
      final response = await http.post(
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _userId = data['localId'];
        _idToken = data['idToken'];
        _userEmail = data['email'];
        _isLoggedIn = true;

        // Fetch user data from database to get the actual name
        await _loadUserDataFromDatabase();
        
        await _saveUserData();
        await _saveUserDataToDatabase();
        notifyListeners();
        print('Login successful');
        return null; // Success
      } else {
        final error = json.decode(response.body);
        return _getErrorMessage(error);
      }
    } catch (e) {
      print('Login error: $e');
      return 'Login failed: $e';
    }
  }

  Future<String?> signup(String email, String password, String name) async {
    try {
      print('Starting signup for: $email');
      
      final response = await http.post(
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      print('Signup response status: ${response.statusCode}');
      print('Signup response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _userId = data['localId'];
        _idToken = data['idToken'];
        _userEmail = data['email'];
        _userName = name;
        _isLoggedIn = true;

        await _saveUserData();
        await _saveUserDataToDatabase();
        notifyListeners();
        print('Signup successful');
        return null; // Success
      } else {
        final error = json.decode(response.body);
        return _getErrorMessage(error);
      }
    } catch (e) {
      print('Signup error: $e');
      return 'Signup failed: $e';
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      print('Starting Google Sign-in');
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google Sign-in cancelled by user');
        return 'Sign-in cancelled';
      }

      print('Google user: ${googleUser.email}');
      print('Google display name: ${googleUser.displayName}');

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('Google auth access token: ${googleAuth.accessToken}');
      print('Google auth ID token: ${googleAuth.idToken}');

      if (googleAuth.idToken != null) {
        // Use the ID token to sign in with Firebase
        final response = await http.post(
          Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$_apiKey'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'postBody': 'id_token=${googleAuth.idToken}&access_token=${googleAuth.accessToken}',
            'requestUri': 'http://localhost:8080',
            'returnIdpCredential': true,
            'returnSecureToken': true,
          }),
        );

        print('Firebase Google sign-in response status: ${response.statusCode}');
        print('Firebase Google sign-in response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          _userId = data['localId'];
          _idToken = data['idToken'];
          _userEmail = data['email'];
          _userName = data['displayName'] ?? googleUser.displayName ?? googleUser.email.split('@')[0];
          _isLoggedIn = true;

          await _saveUserData();
          await _saveUserDataToDatabase();
          notifyListeners();
          print('Google Sign-in successful with ID token');
          return null; // Success
        } else {
          final error = json.decode(response.body);
          return _getErrorMessage(error);
        }
      } else {
        // Fallback: Create user directly with email and name
        print('No ID token available, using fallback method');
        
        // Create a temporary password for Google users
        final tempPassword = 'google_user_${DateTime.now().millisecondsSinceEpoch}';
        
        // Try to create a new user account
        final signupError = await signup(
          googleUser.email,
          tempPassword,
          googleUser.displayName ?? googleUser.email.split('@')[0],
        );
        
        if (signupError != null) {
          // If signup fails (user might already exist), try to sign in
          print('Signup failed, trying to sign in: $signupError');
          return await login(googleUser.email, tempPassword);
        }
        
        return null; // Success
      }
    } catch (e) {
      print('Google Sign-in error: $e');
      return 'Google Sign-in failed: $e';
    }
  }

  Future<void> _saveUserDataToDatabase() async {
    if (_userId == null || _idToken == null) return;

    try {
      print('Saving user data to database for user: $_userId');
      
      // Check if user already exists in database
      final checkResponse = await http.get(
        Uri.parse('$_databaseUrl/users/$_userId.json?auth=$_idToken'),
      );

      String createdAt = DateTime.now().toIso8601String();
      
      if (checkResponse.statusCode == 200) {
        final existingData = json.decode(checkResponse.body);
        if (existingData != null && existingData['createdAt'] != null) {
          createdAt = existingData['createdAt']; // Keep original creation date
          print('User already exists, keeping original creation date: $createdAt');
        }
      }

      final userData = {
        'name': _userName,
        'email': _userEmail,
        'createdAt': createdAt,
        'lastLoginAt': DateTime.now().toIso8601String(),
        'signInMethod': _getSignInMethod(),
      };

      final response = await http.put(
        Uri.parse('$_databaseUrl/users/$_userId.json?auth=$_idToken'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      print('Database save response status: ${response.statusCode}');
      print('Database save response body: ${response.body}');

      if (response.statusCode == 200) {
        print('User data saved to database successfully');
      } else {
        print('Failed to save user data to database: ${response.body}');
      }
    } catch (e) {
      print('Error saving user data to database: $e');
    }
  }

  Future<void> _loadUserDataFromDatabase() async {
    if (_userId == null || _idToken == null) return;

    try {
      print('Loading user data from database for user: $_userId');
      
      final response = await http.get(
        Uri.parse('$_databaseUrl/users/$_userId.json?auth=$_idToken'),
      );

      print('Database load response status: ${response.statusCode}');
      print('Database load response body: ${response.body}');

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        if (userData != null && userData['name'] != null) {
          _userName = userData['name'];
          print('Loaded user name from database: $_userName');
        } else {
          // Fallback if no name is stored
          _userName = _userEmail?.split('@')[0] ?? 'User';
          print('No name found in database, using fallback: $_userName');
        }
      } else {
        // Fallback if database fetch fails
        _userName = _userEmail?.split('@')[0] ?? 'User';
        print('Failed to load user data from database, using fallback: $_userName');
      }
    } catch (e) {
      // Fallback if there's an error
      _userName = _userEmail?.split('@')[0] ?? 'User';
      print('Error loading user data from database: $e, using fallback: $_userName');
    }
  }

  bool _isGoogleUser() {
    // Check if the user signed in with Google
    return _userName != null && _userName!.contains('google_user_');
  }

  String _getSignInMethod() {
    if (_isGoogleUser()) return 'google';
    return 'email';
  }

  Future<String?> resetPassword(String email) async {
    try {
      print('Sending password reset email to: $email');
      
      final response = await http.post(
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'requestType': 'PASSWORD_RESET',
          'email': email,
          'continueUrl': 'https://guideian-b5eb4.firebaseapp.com/__/auth/action',
        }),
      );

      print('Password reset response status: ${response.statusCode}');
      print('Password reset response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Password reset email sent successfully');
        print('Note: Email may be delivered to spam/junk folder');
        return null; // Success
      } else {
        final error = json.decode(response.body);
        final errorMessage = _getErrorMessage(error);
        print('Password reset failed: $errorMessage');
        return errorMessage;
      }
    } catch (e) {
      print('Password reset error: $e');
      return 'Password reset failed: $e';
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print('Google Sign-out error: $e');
    }

    // Facebook logout will be implemented when Facebook auth is added

    _isLoggedIn = false;
    _userEmail = null;
    _userName = null;
    _userId = null;
    _idToken = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  String _getErrorMessage(Map<String, dynamic> error) {
    final message = error['error']?['message'] ?? 'Unknown error';
    switch (message) {
      case 'EMAIL_NOT_FOUND':
        return 'No account found with this email address.';
      case 'INVALID_PASSWORD':
        return 'Incorrect password.';
      case 'USER_DISABLED':
        return 'This account has been disabled.';
      case 'EMAIL_EXISTS':
        return 'An account already exists with this email address.';
      case 'OPERATION_NOT_ALLOWED':
        return 'This sign-in method is not enabled.';
      case 'TOO_MANY_ATTEMPTS_TRY_LATER':
        return 'Too many failed attempts. Please try again later.';
      case 'INVALID_EMAIL':
        return 'Invalid email address.';
      case 'WEAK_PASSWORD':
        return 'Password should be at least 6 characters.';
      default:
        return message;
    }
  }
}