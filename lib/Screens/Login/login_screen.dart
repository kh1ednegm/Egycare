import 'package:egycare/Screens/SignUp/signup_screen.dart';
import 'package:egycare/Screens/home_screen.dart';
import 'package:egycare/components/already_have_an_account_check.dart';
import 'package:egycare/components/custom_textField.dart';
import 'package:egycare/components/password_textField.dart';
import 'package:egycare/components/rounded_button.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  String _userSnn='',_password='';
  String _deviceToken;
  bool _showPassword = true;
  bool _showSnnError = false,
       _passwordError = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;



  @override
  void initState() {
    super.initState();

     _firebaseMessaging.getToken().then((token) {
      _deviceToken = token;
      print('The Token ISSSSSSSSSSSSSSSSSS : $token');
    });
  }

  void showPassword() {
    if (_showPassword == true)
      _showPassword = false;
    else
      _showPassword = true;
  }
  bool _snnValidator(String snnNumber) {
    if (snnNumber.length == 14) {
      if (RegExp(r'([0-9]{14})').hasMatch(snnNumber))
        return snnNumber.isEmpty;
    }
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.05),
                  Image.asset(
                    "assets/images/medical.png",
                    height: size.height * 0.3,
                    //width: size.width * 0.25,
                  ),
                  CustomTextFiled(
                    inputType: TextInputType.number,
                    inputDecoration: InputDecoration(
                      errorText: _showSnnError? 'غير صحيح' : null,
                      border: InputBorder.none,
                      hintText: "الرقم القومي",
                      suffixIcon: Icon(
                        FontAwesomeIcons.solidIdCard,
                        color: kPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      _userSnn = value;
                    },
                  ),

                  PasswordTextField(
                    showPassword: _showPassword,
                    inputDecoration: InputDecoration(
                      errorText: _passwordError ? 'غير صحيح' : null,
                      border: InputBorder.none,
                      hintText: 'الرقم السري',
                      suffixIcon: Icon(
                        FontAwesomeIcons.userLock,
                        color: kPrimaryColor,
                      ),
                      prefixIcon: IconButton(
                          icon: Icon(
                            _showPassword ? Icons.visibility : Icons
                                .visibility_off,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword();
                            });
                          }),
                    ),
                    onChanged: (value) {
                      _password =value;
                    },
                  ),
                  RoundedButton(
                    text: "تسجيل الدخول",
                    press: () async {
                      setState(() {
                        _showSnnError = _snnValidator(_userSnn);
                        _passwordError = (_password.isEmpty);
                      });
                      FocusScope.of(context).unfocus();
                      print(_password);
                      print(_userSnn);
                      if(_showSnnError == false && _passwordError == false){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.white,
                            elevation: 10,
                            content: Text(
                              '...جاري التحميل',
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        );
                        try{
                          var result = await NetworkHelper.login(userSnn: _userSnn, password: _password,deviceToken: _deviceToken);
                          if(result != 0){
                             var token = result['token'];
                             var userId = result['userId'];
                            LocalHelper.saveTokenToLocal(token);
                            LocalHelper.saveIdToLocal(userId);
                             setState(() {
                               ScaffoldMessenger.of(context).hideCurrentSnackBar();
                             });
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'الرقم القومي او الرقم السري غير صحيح',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                                ),
                                action: SnackBarAction(
                                  label: 'الغاء',
                                  onPressed: (){},
                                  textColor: kPrimaryColor,
                                ),
                              ),
                            );
                          }
                        }
                        catch(e){
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                '$e',
                                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                              ),
                              action: SnackBarAction(
                                label: 'الغاء',
                                onPressed: (){

                                },
                                textColor: kPrimaryColor,
                              ),
                            )
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
