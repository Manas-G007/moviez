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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCPHvVhXaFRtFqqZ-6Xd1_x75YtIYFHemA',
    appId: '1:463823851575:web:4ecb89e9570decd93dafb2',
    messagingSenderId: '463823851575',
    projectId: 'moviez-e60db',
    authDomain: 'moviez-e60db.firebaseapp.com',
    storageBucket: 'moviez-e60db.appspot.com',
    measurementId: 'G-3MXZ4M04E2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1944fmTxfHplESMeKBKbtnjDz5FpZBQI',
    appId: '1:463823851575:android:45a47f42ff3bf7723dafb2',
    messagingSenderId: '463823851575',
    projectId: 'moviez-e60db',
    storageBucket: 'moviez-e60db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKJmqkmXiC70NEzXJ2lB-mOwtEuLOXxGM',
    appId: '1:463823851575:ios:20552910847ad0ee3dafb2',
    messagingSenderId: '463823851575',
    projectId: 'moviez-e60db',
    storageBucket: 'moviez-e60db.appspot.com',
    iosClientId: '463823851575-ho4j5f8qb3rfiuhov7co0ikpvg6paklg.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviez',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKJmqkmXiC70NEzXJ2lB-mOwtEuLOXxGM',
    appId: '1:463823851575:ios:5f4e058994e6ae493dafb2',
    messagingSenderId: '463823851575',
    projectId: 'moviez-e60db',
    storageBucket: 'moviez-e60db.appspot.com',
    iosClientId: '463823851575-tue2ek01dfaotm3gg2opv1t6i8so9hvj.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviez.RunnerTests',
  );
}