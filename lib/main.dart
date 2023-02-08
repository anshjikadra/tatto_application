import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tatto_application/screen/home_page.dart';


// FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async{



  WidgetsFlutterBinding.ensureInitialized();
  AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");



  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: home_page(),
  ));
}
