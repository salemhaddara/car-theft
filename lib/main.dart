import 'package:cartheftsafety/core/theme/routes/routes.dart';
import 'package:cartheftsafety/features/login/loginScreen.dart';
import 'package:cartheftsafety/features/signup/SignUpScreen.dart';
import 'package:cartheftsafety/features/splash/splashScreen.dart';
import 'package:cartheftsafety/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messageStreamController = BehaviorSubject<RemoteMessage>();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MaterialApp(
      home: const splashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        loginRoute: (context) => const loginScreen(),
        signUpRoute: (context) => const SignUpScreen()
      }));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    messageStreamController.sink.add(message);
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}
