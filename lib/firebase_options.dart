// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD8mXg65sYZdgj_v0XBNJn6zxwmKLRufPo',
    appId: '1:376540750525:web:49cdac0c7266581d918dd4',
    messagingSenderId: '376540750525',
    projectId: 'flutter-notes-d8f81',
    authDomain: 'flutter-notes-d8f81.firebaseapp.com',
    storageBucket: 'flutter-notes-d8f81.appspot.com',
    measurementId: 'G-E4YG7JXQPR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrdzsFFWzjwiuAHNbPtYTAIs_UdFHXU3M',
    appId: '1:376540750525:android:dbb00702572794d6918dd4',
    messagingSenderId: '376540750525',
    projectId: 'flutter-notes-d8f81',
    storageBucket: 'flutter-notes-d8f81.appspot.com',
  );
}
