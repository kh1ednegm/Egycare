import 'package:egycare/Screens/user_profile_screen.dart';
import 'package:egycare/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class UserMedicalRecordsScreen extends StatefulWidget {
  @override
  _UserMedicalRecordsScreenState createState() =>
      _UserMedicalRecordsScreenState();
}

class _UserMedicalRecordsScreenState extends State<UserMedicalRecordsScreen> {











  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'assets/icons/logo2bg.png',
                      color: Colors.white,
                      height: size.height * 0.1,
                    ),

                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Egycare',
                    style: TextStyle(
                        fontFamily: "Diavlo",
                        color: Colors.white,
                        fontSize: 30),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40))),
                child: GridView.count(
                  padding: EdgeInsets.only(top: size.height * .1),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    CustomCard(
                      imagePath: 'assets/icons/diseases.svg',
                      title: 'الامراض',
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: UserProfileScreen(),
                          withNavBar: true,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/icons/surgury.svg',
                      title: 'العمليات الجراحية',
                    ),
                    CustomCard(
                      imagePath: 'assets/icons/tests.svg',
                      title: 'نتائج التحاليل الطبية',
                    ),
                    CustomCard(
                      imagePath: 'assets/icons/medicences.svg',
                      title: 'الادوية',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title, imagePath;
  final Function onTap;


  CustomCard({
    Key key,
    this.title,
    this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey[50],
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              imagePath,
              height: size.height * 0.16,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: kCardTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
