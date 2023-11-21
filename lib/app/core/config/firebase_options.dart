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
    apiKey: 'AIzaSyCFR9xf1RjeeE5r5NdQTnGH_qFLoEV8kXk',
    appId: '1:472136949613:web:72b24da54522bf90ccc464',
    messagingSenderId: '472136949613',
    projectId: 'penilaian-blt-uta',
    authDomain: 'penilaian-blt-uta.firebaseapp.com',
    storageBucket: 'penilaian-blt-uta.appspot.com',
    measurementId: 'G-N5QXS4YT6N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQIgN8tTmezsmsQz2V5S1cdrNmtmmWU_o',
    appId: '1:472136949613:android:4c6a14e1534dd9a2ccc464',
    messagingSenderId: '472136949613',
    projectId: 'penilaian-blt-uta',
    storageBucket: 'penilaian-blt-uta.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6plpt_RuW6MhH--6PAg2Yk2HaAHvMA68',
    appId: '1:472136949613:ios:222bbc3b602adf61ccc464',
    messagingSenderId: '472136949613',
    projectId: 'penilaian-blt-uta',
    storageBucket: 'penilaian-blt-uta.appspot.com',
    iosBundleId: 'tubes.smt5.penilaian',
  );
}
