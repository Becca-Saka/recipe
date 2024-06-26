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
    apiKey: 'AIzaSyBvUTEnEi5PGwvay7u8fSlQ9dSlvH9hHPk',
    appId: '1:272709421121:web:90919e48290fef8c951ec0',
    messagingSenderId: '272709421121',
    projectId: 'project-recipe-1a94e',
    authDomain: 'project-recipe-1a94e.firebaseapp.com',
    storageBucket: 'project-recipe-1a94e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFVLAMpttIrg1TkeASNJXBJs4cU3muRPM',
    appId: '1:272709421121:android:04003b025f9eb4d7951ec0',
    messagingSenderId: '272709421121',
    projectId: 'project-recipe-1a94e',
    storageBucket: 'project-recipe-1a94e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBAZnSutSGGQEmsOrMkXDcs_887UJKpxI',
    appId: '1:272709421121:ios:b7d9eb5508183a30951ec0',
    messagingSenderId: '272709421121',
    projectId: 'project-recipe-1a94e',
    storageBucket: 'project-recipe-1a94e.appspot.com',
    androidClientId: '272709421121-g4mrb1k14ndm0jiu4jsmnkaab4loia1f.apps.googleusercontent.com',
    iosClientId: '272709421121-82uckepcav8eh0b9d17125ckp0ilpu0c.apps.googleusercontent.com',
    iosBundleId: 'app.recipe.ai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBAZnSutSGGQEmsOrMkXDcs_887UJKpxI',
    appId: '1:272709421121:ios:b7d9eb5508183a30951ec0',
    messagingSenderId: '272709421121',
    projectId: 'project-recipe-1a94e',
    storageBucket: 'project-recipe-1a94e.appspot.com',
    androidClientId: '272709421121-g4mrb1k14ndm0jiu4jsmnkaab4loia1f.apps.googleusercontent.com',
    iosClientId: '272709421121-82uckepcav8eh0b9d17125ckp0ilpu0c.apps.googleusercontent.com',
    iosBundleId: 'app.recipe.ai',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvUTEnEi5PGwvay7u8fSlQ9dSlvH9hHPk',
    appId: '1:272709421121:web:380a1cc8d9b206a5951ec0',
    messagingSenderId: '272709421121',
    projectId: 'project-recipe-1a94e',
    authDomain: 'project-recipe-1a94e.firebaseapp.com',
    storageBucket: 'project-recipe-1a94e.appspot.com',
  );

}