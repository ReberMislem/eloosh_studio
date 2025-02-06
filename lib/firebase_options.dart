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
    apiKey: 'AIzaSyAP9o9MTgTOSDJIMf4WRmIu5oZzx2L506g',
    appId: '1:821831907010:web:0d8a9bec586338100c2d5b',
    messagingSenderId: '821831907010',
    projectId: 'eloosh-d536e',
    authDomain: 'eloosh-d536e.firebaseapp.com',
    storageBucket: 'eloosh-d536e.firebasestorage.app',
    measurementId: 'G-JZLD7R1ZBG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDufrtG9qhkI_Bgwd6MyGFSu8NYoX8Jewk',
    appId: '1:821831907010:android:73c6cc5cc13a864a0c2d5b',
    messagingSenderId: '821831907010',
    projectId: 'eloosh-d536e',
    storageBucket: 'eloosh-d536e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiBKmG1mv2ipAT8oC2QXEy7jSavnNynN8',
    appId: '1:821831907010:ios:45c9f495d4762c830c2d5b',
    messagingSenderId: '821831907010',
    projectId: 'eloosh-d536e',
    storageBucket: 'eloosh-d536e.firebasestorage.app',
    iosBundleId: 'com.example.elooshStudio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiBKmG1mv2ipAT8oC2QXEy7jSavnNynN8',
    appId: '1:821831907010:ios:45c9f495d4762c830c2d5b',
    messagingSenderId: '821831907010',
    projectId: 'eloosh-d536e',
    storageBucket: 'eloosh-d536e.firebasestorage.app',
    iosBundleId: 'com.example.elooshStudio',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAP9o9MTgTOSDJIMf4WRmIu5oZzx2L506g',
    appId: '1:821831907010:web:cf4f11e910e237f10c2d5b',
    messagingSenderId: '821831907010',
    projectId: 'eloosh-d536e',
    authDomain: 'eloosh-d536e.firebaseapp.com',
    storageBucket: 'eloosh-d536e.firebasestorage.app',
    measurementId: 'G-GYFSRL7F0Y',
  );
}
