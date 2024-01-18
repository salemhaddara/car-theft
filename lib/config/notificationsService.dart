import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cartheftsafety/features/alert/alertScreen.dart';
import 'package:cartheftsafety/main.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin notificationPluginFlutter =
      FlutterLocalNotificationsPlugin();
  InitializationSettings settings = const InitializationSettings(
    iOS: DarwinInitializationSettings(),
    android: AndroidInitializationSettings('@mipmap/launcher_icon'),
  );
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user accept permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('user denied permission');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refreshed token ');
    });
  }

  void initializeFirebaseApp(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event, context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('working');
      _handleInitialMessage(event, context);
    });

    // Implement onDidReceiveNotificationResponse for local notifications
    notificationPluginFlutter.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        _handleNotificationData(
            payload.payload as Map<String, dynamic>, context);
      },
    );
  }

  void _handleInitialMessage(RemoteMessage message, BuildContext context) {
    print('Handling initial message: ${message.data}'); // Add debugging
    if (message.data.isNotEmpty) {
      _handleNotificationData(message.data, context);
    }
  }

  Future<void> showNotification(
      RemoteMessage message, BuildContext context) async {
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosSettings = const DarwinInitializationSettings();
    InitializationSettings settings = InitializationSettings(
      iOS: iosSettings,
      android: androidSettings,
    );
    notificationPluginFlutter.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        _handleNotificationData({}, context);
      },
    );

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000000).toString(),
      "Car Cop",
      importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "Car Cop channel description",
      priority: Priority.high,
      importance: Importance.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      notificationPluginFlutter.show(
        30,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: 'data here ',
      );
    });
  }

  void _handleNotificationData(
      Map<String, dynamic> data, BuildContext context) {
    print('Handling notification data: $data'); // Add debugging
    MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: ((context) => const alertScreen()))); // Use navigatorKey
  }
}
