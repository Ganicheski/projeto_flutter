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
    apiKey: 'AIzaSyCC5MG3PArTae64W61W0NyTH-fJRKHRYJk',
    appId: '1:272075372935:web:89569865699d78927dfb22',
    messagingSenderId: '272075372935',
    projectId: 'projeto-a35c9',
    authDomain: 'projeto-a35c9.firebaseapp.com',
    storageBucket: 'projeto-a35c9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBF34qP9bZGcQt7KiRQ1CsKmgwcTGp_qs4',
    appId: '1:272075372935:android:5570fcaa8a96b1bf7dfb22',
    messagingSenderId: '272075372935',
    projectId: 'projeto-a35c9',
    storageBucket: 'projeto-a35c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbUiasP-8vI9YL7IB-0Ceiwdw9KNRNacI',
    appId: '1:272075372935:ios:14ec395f5322950b7dfb22',
    messagingSenderId: '272075372935',
    projectId: 'projeto-a35c9',
    storageBucket: 'projeto-a35c9.appspot.com',
    iosBundleId: 'com.example.projeto',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbUiasP-8vI9YL7IB-0Ceiwdw9KNRNacI',
    appId: '1:272075372935:ios:14ec395f5322950b7dfb22',
    messagingSenderId: '272075372935',
    projectId: 'projeto-a35c9',
    storageBucket: 'projeto-a35c9.appspot.com',
    iosBundleId: 'com.example.projeto',
  );
}