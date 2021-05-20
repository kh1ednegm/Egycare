import 'package:egycare/Screens/Login/login_screen.dart';
import 'package:egycare/Screens/home_screen.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState()  {
    super.initState();

    var d = Duration(seconds: 3);

    Future.delayed(d,()async{
      var token = await LocalHelper.getTokenFromLocal();
      if(token == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      else{
        print(token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

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
}
