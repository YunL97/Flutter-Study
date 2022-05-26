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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBD25xD9EIMGbb-0B1_crQu9_vxuTdWPqU',
    appId: '1:309406692246:android:bd6268347640bc6eff63b7',
    messagingSenderId: '309406692246',
    projectId: 'instagram-clone-applee',
    storageBucket: 'instagram-clone-applee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCN8EmQxdYYDrocCWcllyRZSvqRKY2hVwk',
    appId: '1:309406692246:ios:cc22bfea786519c0ff63b7',
    messagingSenderId: '309406692246',
    projectId: 'instagram-clone-applee',
    storageBucket: 'instagram-clone-applee.appspot.com',
    iosClientId: '309406692246-m7pkmdkg1a9rlphfvq3bf9tlcp5hgi12.apps.googleusercontent.com',
    iosBundleId: 'com.example.fingetxinsta',
  );
}
