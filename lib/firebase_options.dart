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
    apiKey: 'AIzaSyD2Ck2gb5ISvaeGyeK5N4OIg37d5inaA-c',
    appId: '1:923653116855:web:08c929ba9075d0b1b1ce32',
    messagingSenderId: '923653116855',
    projectId: 'shoreguard-1ab3e',
    authDomain: 'shoreguard-1ab3e.firebaseapp.com',
    storageBucket: 'shoreguard-1ab3e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRRXk158PF2OaCm0-F9vv2I1owuuALqF0',
    appId: '1:923653116855:android:247438ef130ff7ddb1ce32',
    messagingSenderId: '923653116855',
    projectId: 'shoreguard-1ab3e',
    storageBucket: 'shoreguard-1ab3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjUos_fR6Zi3ICTBqP_j1RnO-ubHzUOso',
    appId: '1:923653116855:ios:04f5fe9fee127056b1ce32',
    messagingSenderId: '923653116855',
    projectId: 'shoreguard-1ab3e',
    storageBucket: 'shoreguard-1ab3e.appspot.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjUos_fR6Zi3ICTBqP_j1RnO-ubHzUOso',
    appId: '1:923653116855:ios:04f5fe9fee127056b1ce32',
    messagingSenderId: '923653116855',
    projectId: 'shoreguard-1ab3e',
    storageBucket: 'shoreguard-1ab3e.appspot.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2Ck2gb5ISvaeGyeK5N4OIg37d5inaA-c',
    appId: '1:923653116855:web:f92e1e73b03f1b0db1ce32',
    messagingSenderId: '923653116855',
    projectId: 'shoreguard-1ab3e',
    authDomain: 'shoreguard-1ab3e.firebaseapp.com',
    storageBucket: 'shoreguard-1ab3e.appspot.com',
  );
}
