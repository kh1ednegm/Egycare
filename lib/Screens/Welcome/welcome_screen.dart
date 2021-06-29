import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:egycare/Screens/Login/login_screen.dart';
import 'package:egycare/Screens/home_screen.dart';
import 'package:egycare/Screens/user_blood_donation_screen.dart';
import 'package:egycare/models/blood_donation_model.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:egycare/global_variable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print('التطبيق ف الباك جرواند');

  print('روح ع صفحة التبرع');
  pushNewScreen(
    GlobalVariable.navigatorKey.currentState.context,
    screen: UserBloodDonationScreen(),
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );
}

var id;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Egycare',
              style: TextStyle(fontFamily: 'Diavlo',fontSize: 40),
            ),
            SizedBox(height: 20,),
            SvgPicture.asset(
              "assets/icons/intro.svg",
              height: size.height * 0.25,
              width: size.width * 0.25,
            ),
          ],
        ),
      ),
    );
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState()  {

    registerNotification();
    checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('WWWWWWWWWWWWWWWWWWWWW');
      pushNewScreen(
        GlobalVariable.navigatorKey.currentState.context,
        screen: UserBloodDonationScreen(),
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });




    super.initState();

    var d = Duration(seconds: 3);

    Future.delayed(d,()async{
      var token = await LocalHelper.getTokenFromLocal();
      if(token == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      else{
        print(token);
        id = await LocalHelper.getIdFromLocal();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }


  void registerNotification() async {

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('AUTHORIZED');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        if (notification != null && android != null) {
          // For displaying the notification as an overlay
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: message.notification?.title,
              body: message.notification?.body,
            ),
          );

        }
      });
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    print('البرنامج مقفول خالص');
    RemoteMessage initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      pushNewScreen(
        context,
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
        screen: UserBloodDonationScreen(),
      );

    }
  }
}
