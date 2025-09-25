import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../firebase_options.dart';

class FirebaseService {
  static FirebaseAuth? _auth;
  static FirebaseFirestore? _firestore;
  static FirebaseStorage? _storage;
  static FirebaseAnalytics? _analytics;
  static FirebaseMessaging? _messaging;

  /// Initialize Firebase services
  static Future<void> initialize() async {
    try {
      // Initialize Firebase Core
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Initialize Firebase Auth
      _auth = FirebaseAuth.instance;

      // Initialize Firestore
      _firestore = FirebaseFirestore.instance;

      // Initialize Firebase Storage
      _storage = FirebaseStorage.instance;

      // Initialize Firebase Analytics
      _analytics = FirebaseAnalytics.instance;

      // Initialize Firebase Messaging
      _messaging = FirebaseMessaging.instance;

      // Configure Firebase settings (non-blocking)
      _configureFirebase();

      if (kDebugMode) {
        print('✅ Firebase services initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing Firebase: $e');
      }
      // Don't rethrow - let the app continue without Firebase
    }
  }

  /// Configure Firebase settings
  static void _configureFirebase() {
    try {
      // Configure Firestore settings
      _firestore?.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      // Configure Firebase Messaging (non-blocking)
      _messaging?.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Request notification permissions (non-blocking)
      _requestNotificationPermissions();
    } catch (e) {
      if (kDebugMode) {
        print('Error configuring Firebase: $e');
      }
    }
  }

  /// Request notification permissions
  static Future<void> _requestNotificationPermissions() async {
    try {
      final settings = await _messaging?.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('Notification permission status: ${settings?.authorizationStatus}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting notification permissions: $e');
      }
    }
  }

  /// Get Firebase Auth instance
  static FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception('Firebase Auth not initialized. Call FirebaseService.initialize() first.');
    }
    return _auth!;
  }

  /// Get Firestore instance
  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception('Firestore not initialized. Call FirebaseService.initialize() first.');
    }
    return _firestore!;
  }

  /// Get Firebase Storage instance
  static FirebaseStorage get storage {
    if (_storage == null) {
      throw Exception('Firebase Storage not initialized. Call FirebaseService.initialize() first.');
    }
    return _storage!;
  }

  /// Get Firebase Analytics instance
  static FirebaseAnalytics get analytics {
    if (_analytics == null) {
      throw Exception('Firebase Analytics not initialized. Call FirebaseService.initialize() first.');
    }
    return _analytics!;
  }


  /// Get Firebase Messaging instance
  static FirebaseMessaging get messaging {
    if (_messaging == null) {
      throw Exception('Firebase Messaging not initialized. Call FirebaseService.initialize() first.');
    }
    return _messaging!;
  }

  /// Log custom analytics event
  static Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    try {
      await _analytics?.logEvent(name: name, parameters: parameters);
    } catch (e) {
      if (kDebugMode) {
        print('Error logging analytics event: $e');
      }
    }
  }

  /// Set user properties for analytics
  static Future<void> setUserProperties(Map<String, String> properties) async {
    try {
      for (final entry in properties.entries) {
        await _analytics?.setUserProperty(
          name: entry.key,
          value: entry.value,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error setting user properties: $e');
      }
    }
  }


  /// Get FCM token for push notifications
  static Future<String?> getFCMToken() async {
    try {
      return await _messaging?.getToken();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting FCM token: $e');
      }
      return null;
    }
  }

  /// Subscribe to topic for push notifications
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging?.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Subscribed to topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error subscribing to topic: $e');
      }
    }
  }

  /// Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging?.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Unsubscribed from topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error unsubscribing from topic: $e');
      }
    }
  }
}
