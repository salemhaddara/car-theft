import 'package:cartheftsafety/config/notificationsService.dart';
import 'package:cartheftsafety/core/theme/routes/routes.dart';
import 'package:cartheftsafety/features/alert/alertScreen.dart';
import 'package:cartheftsafety/features/home/homeScreen.dart';
import 'package:cartheftsafety/features/login/loginScreen.dart';
import 'package:cartheftsafety/features/signup/SignUpScreen.dart';
import 'package:cartheftsafety/features/splash/splashScreen.dart';
// import 'package:cartheftsafety/features/splash/splashScreen.dart';
import 'package:cartheftsafety/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NotificationService.navigatorKey,
      home: const alertScreen(),
      routes: {
        loginRoute: (context) => const loginScreen(),
        signUpRoute: (context) => const SignUpScreen(),
      },
      onGenerateRoute: (settings) {
        final RemoteMessage? initialMessage =
            settings.arguments as RemoteMessage?;
        if (initialMessage != null) {
          return MaterialPageRoute(
            builder: (context) => const homeScreen(),
          );
        }
        return MaterialPageRoute(builder: (context) => const splashScreen());
      },
    );
  }
}
