// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhq1-DVFEwTpoACqyTu4vRvKP587gOnyk',
    appId: '1:650302404593:web:752dc8aa61e67099ec7650',
    messagingSenderId: '650302404593',
    projectId: 'sabetas-3105',
    authDomain: 'sabetas-3105.firebaseapp.com',
    storageBucket: 'sabetas-3105.appspot.com',
    measurementId: 'G-VY17HKXXEP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPefvEHcP98W5foes4jX64lF3oEysHt_o',
    appId: '1:650302404593:android:120ca2a519bea6beec7650',
    messagingSenderId: '650302404593',
    projectId: 'sabetas-3105',
    storageBucket: 'sabetas-3105.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBT5NkoS9Iwi0KBpuQsTFJOmV3pmg5guc8',
    appId: '1:650302404593:ios:685fec256d51d6c5ec7650',
    messagingSenderId: '650302404593',
    projectId: 'sabetas-3105',
    storageBucket: 'sabetas-3105.appspot.com',
    iosBundleId: 'com.example.sabetas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBT5NkoS9Iwi0KBpuQsTFJOmV3pmg5guc8',
    appId: '1:650302404593:ios:685fec256d51d6c5ec7650',
    messagingSenderId: '650302404593',
    projectId: 'sabetas-3105',
    storageBucket: 'sabetas-3105.appspot.com',
    iosBundleId: 'com.example.sabetas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhq1-DVFEwTpoACqyTu4vRvKP587gOnyk',
    appId: '1:650302404593:web:3d1aa0b79ac68091ec7650',
    messagingSenderId: '650302404593',
    projectId: 'sabetas-3105',
    authDomain: 'sabetas-3105.firebaseapp.com',
    storageBucket: 'sabetas-3105.appspot.com',
    measurementId: 'G-WXJHST5K9S',
  );
}
