import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    if (user != null) {
      _isLoggedIn = true;
      _userEmail = user.email;
      _userName = user.displayName ?? user.email?.split('@')[0];
      _userId = user.uid;
    } else {
      _isLoggedIn = false;
      _userEmail = null;
      _userName = null;
      _userId = null;
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      _setLoading(true);
      
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', _userName ?? '');
        await prefs.setString('userId', userCredential.user!.uid);
        
        return null; // Success
      }
      return 'Login failed';
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return 'Login failed: ${e.message}';
      }
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signup(String email, String password, String name, String grade) async {
    try {
      _setLoading(true);
      
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update display name
        await userCredential.user!.updateDisplayName(name);
        
        // Save additional user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': name,
          'email': email,
          'grade': grade,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
        });

        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', name);
        await prefs.setString('userId', userCredential.user!.uid);
        
        return null; // Success
      }
      return 'Signup failed';
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'invalid-email':
          return 'The email address is not valid.';
        default:
          return 'Signup failed: ${e.message}';
      }
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return 'Google sign-in was cancelled';
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        // Check if user exists in Firestore, if not create them
        final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
        if (!userDoc.exists) {
          await _firestore.collection('users').doc(userCredential.user!.uid).set({
            'name': userCredential.user!.displayName ?? '',
            'email': userCredential.user!.email ?? '',
            'grade': 'Not specified',
            'createdAt': FieldValue.serverTimestamp(),
            'lastLoginAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Update last login time
          await _firestore.collection('users').doc(userCredential.user!.uid).update({
            'lastLoginAt': FieldValue.serverTimestamp(),
          });
        }

        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', userCredential.user!.email ?? '');
        await prefs.setString('userName', userCredential.user!.displayName ?? '');
        await prefs.setString('userId', userCredential.user!.uid);
        
        return null; // Success
      }
      return 'Google sign-in failed';
    } catch (e) {
      _setLoading(false);
      return 'Google sign-in error: $e';
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      _setLoading(true);
      // Note: Facebook sign-in requires additional setup with facebook_login package
      // For now, we'll return a message indicating it's not implemented
      _setLoading(false);
      return 'Facebook sign-in is not yet implemented. Please use email/password or Google sign-in.';
    } catch (e) {
      _setLoading(false);
      return 'Facebook sign-in error: $e';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      _setLoading(true);
      await _auth.sendPasswordResetEmail(email: email);
      _setLoading(false);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'invalid-email':
          return 'The email address is not valid.';
        default:
          return 'Password reset failed: ${e.message}';
      }
    } catch (e) {
      _setLoading(false);
      return 'An unexpected error occurred: $e';
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      
      // Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
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
      final doc = await _firestore.collection('users').doc(_userId!).get();
      if (doc.exists) {
        return doc.data();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }
}