# Guideian Flutter App - Firebase Mobile Configuration Guide

This guide will help you set up Firebase for your Flutter app to run on mobile devices (Android and iOS) with all the necessary services and configurations.

## 🚀 Quick Setup Overview

Your Flutter app is now configured with:
- ✅ **Firebase Authentication** - User login/signup
- ✅ **Cloud Firestore** - Database for user data
- ✅ **Firebase Storage** - File storage
- ✅ **Firebase Analytics** - User behavior tracking
- ✅ **Firebase Crashlytics** - Crash reporting
- ✅ **Firebase Messaging** - Push notifications
- ✅ **Google Sign-In** - Social authentication

## 📱 Platform-Specific Setup

### Android Setup

#### 1. Firebase Console Configuration

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `guideian-b5eb4`
3. Click **Add app** → **Android**
4. **Package name**: `com.guideian.app`
5. **App nickname**: `Guideian Android`
6. Download `google-services.json`

#### 2. Replace Configuration File

Replace the placeholder `google-services.json` in your project:

```bash
# Remove the placeholder file
rm guideian_app/android/app/google-services.json

# Add your actual google-services.json from Firebase Console
cp ~/Downloads/google-services.json guideian_app/android/app/
```

#### 3. Update App ID in firebase_options.dart

After downloading the real `google-services.json`, update the Android app ID:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_API_KEY',
  appId: '1:723263641111:android:YOUR_ACTUAL_APP_ID', // Update this
  messagingSenderId: '723263641111',
  projectId: 'guideian-b5eb4',
  databaseURL: 'https://guideian-b5eb4-default-rtdb.firebaseio.com',
  storageBucket: 'guideian-b5eb4.firebasestorage.app',
);
```

### iOS Setup

#### 1. Firebase Console Configuration

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `guideian-b5eb4`
3. Click **Add app** → **iOS**
4. **Bundle ID**: `com.guideian.app`
5. **App nickname**: `Guideian iOS`
6. Download `GoogleService-Info.plist`

#### 2. Replace Configuration File

Replace the placeholder `GoogleService-Info.plist` in your project:

```bash
# Remove the placeholder file
rm guideian_app/ios/Runner/GoogleService-Info.plist

# Add your actual GoogleService-Info.plist from Firebase Console
cp ~/Downloads/GoogleService-Info.plist guideian_app/ios/Runner/
```

#### 3. Update App ID in firebase_options.dart

After downloading the real `GoogleService-Info.plist`, update the iOS app ID:

```dart
static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_API_KEY',
  appId: '1:723263641111:ios:YOUR_ACTUAL_APP_ID', // Update this
  messagingSenderId: '723263641111',
  projectId: 'guideian-b5eb4',
  databaseURL: 'https://guideian-b5eb4-default-rtdb.firebaseio.com',
  storageBucket: 'guideian-b5eb4.firebasestorage.app',
  iosBundleId: 'com.guideian.app',
);
```

## 🔧 Firebase Services Configuration

### 1. Authentication Setup

Enable authentication methods in Firebase Console:

1. Go to **Authentication** → **Sign-in method**
2. Enable the following providers:
   - ✅ **Email/Password**
   - ✅ **Google** (for Google Sign-In)

#### Google Sign-In Configuration

**For Android:**
1. In Firebase Console, go to **Authentication** → **Sign-in method** → **Google**
2. Add your Android package name: `com.guideian.app`
3. Add your SHA-1 fingerprint (get it using):
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

**For iOS:**
1. In Firebase Console, go to **Authentication** → **Sign-in method** → **Google**
2. Add your iOS bundle ID: `com.guideian.app`

### 2. Firestore Database Setup

1. Go to **Firestore Database** → **Create database**
2. Choose **Start in test mode** (for development)
3. Select a location (choose closest to your users)

#### Security Rules (Development)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read/write access to all users (for development only)
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### Security Rules (Production)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Public data (courses, etc.)
    match /courses/{document=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### 3. Firebase Storage Setup

1. Go to **Storage** → **Get started**
2. Choose **Start in test mode** (for development)
3. Select the same location as Firestore

#### Storage Rules (Development)

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### 4. Firebase Analytics Setup

Analytics is automatically enabled when you initialize Firebase. No additional setup required.

### 5. Firebase Crashlytics Setup

1. Go to **Crashlytics** → **Get started**
2. The configuration is already set up in your code

### 6. Firebase Messaging Setup

1. Go to **Cloud Messaging** → **Get started**
2. The configuration is already set up in your code

## 📱 Testing Your Setup

### 1. Run on Android

```bash
# Get dependencies
flutter pub get

# Run on Android device/emulator
flutter run -d android
```

### 2. Run on iOS

```bash
# Get dependencies
flutter pub get

# Run on iOS device/simulator
flutter run -d ios
```

### 3. Test Firebase Services

Add this test code to verify Firebase is working:

```dart
// Test Firebase connection
import 'package:firebase_auth/firebase_auth.dart';

Future<void> testFirebase() async {
  try {
    // Test Authentication
    final user = FirebaseAuth.instance.currentUser;
    print('Current user: ${user?.email ?? "Not signed in"}');
    
    // Test Firestore
    final doc = await FirebaseFirestore.instance
        .collection('test')
        .doc('test')
        .get();
    print('Firestore test: ${doc.exists}');
    
    // Test Analytics
    await FirebaseAnalytics.instance.logEvent(
      name: 'test_event',
      parameters: {'test': 'value'},
    );
    
    print('✅ All Firebase services working!');
  } catch (e) {
    print('❌ Firebase error: $e');
  }
}
```

## 🚀 Build and Deploy

### 1. Build APK (Android)

```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

### 2. Build IPA (iOS)

```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

### 3. App Store Deployment

#### Google Play Store (Android)

1. Generate signed APK/AAB:
   ```bash
   flutter build appbundle --release
   ```

2. Upload to [Google Play Console](https://play.google.com/console)

#### Apple App Store (iOS)

1. Build for release:
   ```bash
   flutter build ios --release
   ```

2. Use Xcode to archive and upload to [App Store Connect](https://appstoreconnect.apple.com)

## 🔐 Security Best Practices

### 1. Environment Configuration

Never commit sensitive configuration files to version control:

```bash
# Add to .gitignore
google-services.json
GoogleService-Info.plist
```

### 2. API Keys

- Use Firebase App Check for additional security
- Implement proper Firestore security rules
- Use Firebase Functions for sensitive operations

### 3. Authentication

- Implement proper error handling
- Use secure authentication flows
- Validate user inputs

## 🛠️ Troubleshooting

### Common Issues

1. **Build fails with "google-services.json not found"**
   - Ensure you've downloaded and placed the correct configuration file
   - Check that the package name matches

2. **Google Sign-In not working**
   - Verify SHA-1 fingerprint is added to Firebase Console
   - Check that the correct OAuth client is configured

3. **Firestore permission denied**
   - Check your security rules
   - Ensure user is authenticated

4. **Push notifications not working**
   - Check device permissions
   - Verify FCM token is generated

### Debug Commands

```bash
# Check Firebase configuration
flutter doctor

# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check Firebase logs
flutter logs
```

## 📊 Monitoring and Analytics

### 1. Firebase Analytics Dashboard

- View user engagement metrics
- Track custom events
- Monitor app performance

### 2. Crashlytics Dashboard

- Monitor app crashes
- Track error trends
- Get stack traces

### 3. Performance Monitoring

- Monitor app startup time
- Track network requests
- Monitor database queries

## 🔄 CI/CD Integration

Your app is already configured with GitHub Actions for automated deployment. The workflow will:

1. ✅ Run tests
2. 🏗️ Build the app
3. 🚀 Deploy to app stores (when configured)

## 📞 Support

- **Firebase Documentation**: [Firebase Flutter Docs](https://firebase.flutter.dev/)
- **Flutter Documentation**: [Flutter Docs](https://flutter.dev/docs)
- **GitHub Issues**: Create an issue in your repository

---

## 🎉 You're All Set!

Your Flutter app is now fully configured with Firebase for mobile devices! You can:

- ✅ **Authenticate users** with email/password and Google Sign-In
- ✅ **Store data** in Firestore database
- ✅ **Upload files** to Firebase Storage
- ✅ **Track analytics** and user behavior
- ✅ **Monitor crashes** and app performance
- ✅ **Send push notifications** to users
- ✅ **Deploy to app stores** with automated CI/CD

**Next Steps:**
1. Replace placeholder configuration files with real ones from Firebase Console
2. Test all Firebase services
3. Set up proper security rules
4. Deploy to Google Play Store and Apple App Store

Happy coding! 🚀
