import 'package:egycare/Screens/Login/login_screen.dart';
import 'package:egycare/Screens/profileScreens/edit_screen.dart';
import 'package:egycare/components/custom_text_tile.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/main.dart';
import 'package:egycare/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:egycare/components/rounded_button.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class UserProfileScreen extends StatefulWidget {


  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();

}

class _UserProfileScreenState extends State<UserProfileScreen> {


  Future<UserModel> personalInformation;


  @override
  void initState() {
    personalInformation = NetworkHelper.getPersonalInfoUsingId();
    super.initState();
  }

  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
          FutureBuilder<UserModel>(
              future:personalInformation,
              builder:(BuildContext context,AsyncSnapshot snapshot)
              {
                if( snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                    height: size.height,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.2,
                          padding: EdgeInsets.only(top: size.height * 0.04),
                          decoration: BoxDecoration(
                            color: Color(0xFF0080F6),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                bottomRight: Radius.circular(23)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    child: Image.asset(
                                      'assets/icons/logo2bg.png',
                                      color: Colors.white,
                                      height: size.height * 0.08,
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
                              Text(
                                'الملف الشخصي',
                                style: kCardTextStyle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Center(
                          child: Container(
                            width: size.width ,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top:size.height * 0.06),
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('جاري التحميل'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else if (snapshot.hasError) {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.2,
                          padding: EdgeInsets.only(top: size.height * 0.04),
                          decoration: BoxDecoration(
                            color: Color(0xFF0080F6),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                bottomRight: Radius.circular(23)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    child: Image.asset(
                                      'assets/icons/logo2bg.png',
                                      color: Colors.white,
                                      height: size.height * 0.08,
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
                              Text(
                                'الملف الشخصي',
                                style: kCardTextStyle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          width: size.width ,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/not_found.svg',
                                height: size.height * 0.25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('حدث خطأ غير متوقع'),
                              ),
                              TextButton(
                                child: Text('حاول مرة اخري'),
                                onPressed: ()async{
                                  personalInformation =  NetworkHelper.getPersonalInfoUsingId();
                                  setState(() {

                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else{
                  UserModel userModel=snapshot.data;
                  return  Column(
                    children: [
                      Container(
                        height: size.height * 0.2,
                        padding: EdgeInsets.only(top: size.height * 0.04),
                        decoration: BoxDecoration(
                          color: Color(0xFF0080F6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(23),
                              bottomRight: Radius.circular(23)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(

                                  child: Image.asset(
                                    'assets/icons/logo2bg.png',
                                    color: Colors.white,
                                    height: size.height * 0.08,
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
                            Text(
                              'الملف الشخصي',
                              style: kCardTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: Column(
                          children: [
                            CustomTextTile(title: 'الاسم', value: userModel.fullName,thickness: 1.5,),
                            CustomTextTile(title: 'العنوان', value: userModel.city,thickness: 1.5,),
                            CustomTextTile(title: 'العمر', value:( DateTime.now().difference(DateTime.parse(userModel.dateOfBirth)).inDays/365).floor().toString(),thickness: 1.5,),
                            CustomTextTile(title: 'الجنس', value: userModel.gender,thickness: 1.5,),
                            CustomTextTile(title: 'رقم الموبايل', value: userModel.phoneNumber,thickness: 1.5,),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Color(0xFF0080F6),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Text(
                                'بيانات الاقارب',
                                textAlign: TextAlign.center,
                                style: kCardTextStyle.copyWith(fontSize: 30,color: Colors.white),
                              ),),
                            Divider(
                              indent: 24,
                              endIndent: 24,
                              thickness: 1.5,

                            ),
                            CustomTextTile(title: 'الاسم',value: userModel.firstRelativeName,thickness: 1.5,),
                            CustomTextTile(title: 'رقم الموبايل', value:userModel.firstRelativePhoneNumber,thickness:1.5 ,),
                            CustomTextTile(title: 'الاسم', value: userModel.secondRelativeName,thickness: 1.5,),
                            CustomTextTile(title: 'رقم الموبايل', value: userModel.secondRelativePhoneNumber,thickness: 0.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    // width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                      child: Text('تسجيل الخروج',
                                        style: TextStyle(
                                            color: Colors.white,
                                          fontSize: 22,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                  ),
                                  onPressed: () async{
                                    await LocalHelper.logOut();
                                    pushNewScreen(
                                        context,
                                        screen: LoginScreen(),
                                      withNavBar: false,
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    // width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text("تعديل البيانات",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22
                                      ),),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditScreen(user:userModel)),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }

              }
          ),

        ),
      ),
    );

  }


}