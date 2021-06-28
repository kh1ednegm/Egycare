import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:egycare/Screens/Welcome/welcome_screen.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/global_variable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

SharedPreferences prefs;

void main() async{
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      'resource://drawable/logon',
    [
      NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: kPrimaryColor,
      ledColor: Colors.white,
      ),
    ]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        navigatorKey: GlobalVariable.navigatorKey,        theme: ThemeData(fontFamily: 'Cairo'),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
    );
  }
}

