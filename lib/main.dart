import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tatto_application/screen/home_page.dart';


FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async{



  WidgetsFlutterBinding.ensureInitialized();



  AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings
  );

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log(response.payload.toString());
      }
  );

  log("Notifications: $initialized");



  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: home_page(),
  ));
}
