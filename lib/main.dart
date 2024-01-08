import 'package:cartheftsafety/core/theme/routes/routes.dart';
import 'package:cartheftsafety/features/login/loginScreen.dart';
import 'package:cartheftsafety/features/signup/SignUpScreen.dart';
import 'package:cartheftsafety/features/splash/splashScreen.dart';
import 'package:cartheftsafety/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      home: const splashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        loginRoute: (context) => const loginScreen(),
        signUpRoute: (context) => const SignUpScreen()
      }));
}
