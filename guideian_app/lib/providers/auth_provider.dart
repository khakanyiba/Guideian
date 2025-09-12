import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '723263641111-cf6ee50tgv17gsi1c6v4ds4v9u8jd2kn.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  // Firebase configuration from your HTML files
  static const String _apiKey = "AIzaSyB41Go0wudzjur1xcPO4t-_gk9fGYccgg4";
  static const String _authDomain = "guideian-b5eb4.firebaseapp.com";
  static const String _databaseUrl = "https://guideian-b5eb4-default-rtdb.firebaseio.com";

  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userName;
  String? _userId;
  String? _idToken;
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
      
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
      
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _idToken = data['idToken'];
        _userId = data['localId'];
        _userEmail = data['email'];
        _userName = data['displayName'] ?? email.split('@')[0];
        _isLoggedIn = true;
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', _userName!);
        await prefs.setString('userId', _userId!);
        await prefs.setString('idToken', _idToken!);
        
        notifyListeners();
        return null; // Success
      } else {
        final error = json.decode(response.body);
        _setLoading(false);
        return _getErrorMessage(error['error']['message']);
      }
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signup(String email, String password, String name, String grade) async {
    try {
      _setLoading(true);
      
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
      
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _idToken = data['idToken'];
        _userId = data['localId'];
        _userEmail = data['email'];
        _userName = name;
        _isLoggedIn = true;
        
        // Save additional user data to Firebase Realtime Database
        await _saveUserData(_userId!, {
          'name': name,
          'email': email,
          'grade': grade,
          'createdAt': DateTime.now().toIso8601String(),
          'lastLoginAt': DateTime.now().toIso8601String(),
        });
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', name);
        await prefs.setString('userId', _userId!);
        await prefs.setString('idToken', _idToken!);
        
        notifyListeners();
        return null; // Success
      } else {
        final error = json.decode(response.body);
        _setLoading(false);
        return _getErrorMessage(error['error']['message']);
      }
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);
      
      // First, try to sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return 'Google sign-in was cancelled';
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      print('Google Auth Debug:');
      print('ID Token: ${googleAuth.idToken}');
      print('Access Token: ${googleAuth.accessToken}');
      print('User Email: ${googleUser.email}');
      print('User Name: ${googleUser.displayName}');
      
      // If we don't have an ID token, we can still proceed with the user info
      if (googleAuth.idToken == null) {
        print('No ID token available, using user info directly');
        
        // First, try to create a Firebase user account using email/password
        try {
          final createUserUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
          final createUserResponse = await http.post(
            Uri.parse(createUserUrl),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'email': googleUser.email,
              'password': 'google_${googleUser.id}_${DateTime.now().millisecondsSinceEpoch}', // Generate a random password
              'returnSecureToken': true,
            }),
          );
          
          if (createUserResponse.statusCode == 200) {
            final createUserData = json.decode(createUserResponse.body);
            _idToken = createUserData['idToken'];
            _userId = createUserData['localId'];
            print('Created Firebase user with ID: $_userId');
          } else {
            // If user already exists, try to sign in
            final signInUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
            final signInResponse = await http.post(
              Uri.parse(signInUrl),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'email': googleUser.email,
                'password': 'google_${googleUser.id}_${DateTime.now().millisecondsSinceEpoch}',
                'returnSecureToken': true,
              }),
            );
            
            if (signInResponse.statusCode == 200) {
              final signInData = json.decode(signInResponse.body);
              _idToken = signInData['idToken'];
              _userId = signInData['localId'];
              print('Signed in existing Firebase user with ID: $_userId');
            } else {
              // Fallback to local user ID
              _userId = 'google_${googleUser.id}';
              _idToken = 'google_token_${DateTime.now().millisecondsSinceEpoch}';
              print('Using fallback user ID: $_userId');
            }
          }
        } catch (e) {
          print('Error creating Firebase user: $e');
          // Fallback to local user ID
          _userId = 'google_${googleUser.id}';
          _idToken = 'google_token_${DateTime.now().millisecondsSinceEpoch}';
        }
        
        _userEmail = googleUser.email;
        _userName = googleUser.displayName ?? 'Google User';
        _isLoggedIn = true;
        
        // Save user data to Firebase Realtime Database
        await _saveUserData(_userId!, {
          'name': _userName,
          'email': _userEmail,
          'createdAt': DateTime.now().toIso8601String(),
          'lastLoginAt': DateTime.now().toIso8601String(),
          'signInMethod': 'google',
          'googleId': googleUser.id,
        });
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', _userEmail!);
        await prefs.setString('userName', _userName!);
        await prefs.setString('userId', _userId!);
        await prefs.setString('idToken', _idToken!);
        
        notifyListeners();
        return null; // Success
      }
      
      // If we have an ID token, use Firebase REST API
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$_apiKey';
      
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'postBody': 'id_token=${googleAuth.idToken}&access_token=${googleAuth.accessToken}',
          'requestUri': 'http://localhost:8080',
          'returnIdToken': true,
          'returnSecureToken': true,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _idToken = data['idToken'];
        _userId = data['localId'];
        _userEmail = data['email'];
        _userName = data['displayName'] ?? 'Google User';
        _isLoggedIn = true;
        
        // Save user data to Firebase Realtime Database
        await _saveUserData(_userId!, {
          'name': _userName,
          'email': _userEmail,
          'createdAt': DateTime.now().toIso8601String(),
          'lastLoginAt': DateTime.now().toIso8601String(),
          'signInMethod': 'google',
        });
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', _userEmail!);
        await prefs.setString('userName', _userName!);
        await prefs.setString('userId', _userId!);
        await prefs.setString('idToken', _idToken!);
        
        notifyListeners();
        return null; // Success
      } else {
        final error = json.decode(response.body);
        _setLoading(false);
        return 'Google sign-in failed: ${error['error']['message']}';
      }
    } catch (e) {
      _setLoading(false);
      return 'Google sign-in error: $e';
    }
  }


  Future<String?> resetPassword(String email) async {
    try {
      _setLoading(true);
      
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey';
      
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'requestType': 'PASSWORD_RESET',
          'email': email,
        }),
      );
      
      if (response.statusCode == 200) {
        _setLoading(false);
        return null; // Success
      } else {
        final error = json.decode(response.body);
        _setLoading(false);
        return _getErrorMessage(error['error']['message']);
      }
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<void> logout() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();
      
      // Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('userEmail');
      await prefs.remove('userName');
      await prefs.remove('userId');
      await prefs.remove('idToken');
      
      _isLoggedIn = false;
      _userEmail = null;
      _userName = null;
      _userId = null;
      _idToken = null;
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
    _idToken = prefs.getString('idToken');
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    if (_userId == null) return null;
    
    try {
      final url = '$_databaseUrl/users/$_userId.json';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          return Map<String, dynamic>.from(data);
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  Future<void> _saveUserData(String userId, Map<String, dynamic> userData) async {
    try {
      final url = '$_databaseUrl/users/$userId.json';
      print('Saving user data to: $url');
      print('User data: $userData');
      
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );
      
      print('Database response status: ${response.statusCode}');
      print('Database response body: ${response.body}');
      
      if (response.statusCode != 200) {
        print('Failed to save user data: ${response.statusCode} - ${response.body}');
      } else {
        print('User data saved successfully!');
      }
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'EMAIL_NOT_FOUND':
        return 'No user found with this email address.';
      case 'INVALID_PASSWORD':
        return 'Wrong password provided.';
      case 'INVALID_EMAIL':
        return 'The email address is not valid.';
      case 'USER_DISABLED':
        return 'This user account has been disabled.';
      case 'TOO_MANY_ATTEMPTS_TRY_LATER':
        return 'Too many attempts. Please try again later.';
      case 'WEAK_PASSWORD':
        return 'The password provided is too weak.';
      case 'EMAIL_EXISTS':
        return 'An account already exists for this email.';
      case 'OPERATION_NOT_ALLOWED':
        return 'This operation is not allowed.';
      default:
        return 'Authentication failed: $errorCode';
    }
  }
}