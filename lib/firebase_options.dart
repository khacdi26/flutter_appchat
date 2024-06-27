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
    apiKey: 'AIzaSyAPFnQK6P7I_mk7EhRzXnbahYdXbjXBo1Q',
    appId: '1:923590803749:web:aaf57518dfc01599945acc',
    messagingSenderId: '923590803749',
    projectId: 'appchat-dabcf',
    authDomain: 'appchat-dabcf.firebaseapp.com',
    storageBucket: 'appchat-dabcf.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7jGLGr1oduL6APnsoSfoJmavfSmyOJ9Q',
    appId: '1:923590803749:android:c9b04a4fb9b92731945acc',
    messagingSenderId: '923590803749',
    projectId: 'appchat-dabcf',
    storageBucket: 'appchat-dabcf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCg464kaFXEkV4UGZZIC5fj8Y5VfU8lKPo',
    appId: '1:923590803749:ios:a88945ca00e7e8c7945acc',
    messagingSenderId: '923590803749',
    projectId: 'appchat-dabcf',
    storageBucket: 'appchat-dabcf.appspot.com',
    iosBundleId: 'com.example.flutterAppChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCg464kaFXEkV4UGZZIC5fj8Y5VfU8lKPo',
    appId: '1:923590803749:ios:a88945ca00e7e8c7945acc',
    messagingSenderId: '923590803749',
    projectId: 'appchat-dabcf',
    storageBucket: 'appchat-dabcf.appspot.com',
    iosBundleId: 'com.example.flutterAppChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAPFnQK6P7I_mk7EhRzXnbahYdXbjXBo1Q',
    appId: '1:923590803749:web:0d71a9f5e35a32a6945acc',
    messagingSenderId: '923590803749',
    projectId: 'appchat-dabcf',
    authDomain: 'appchat-dabcf.firebaseapp.com',
    storageBucket: 'appchat-dabcf.appspot.com',
  );
}
