import 'package:flutter/material.dart';
import '../constants.dart';


class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "انشاء حساب" : "تسجيل الدخول",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),
        SizedBox(width: 8,),
        Text(
          login ? "ليس لديك حساب ؟" : "لديك حساب ؟ ",
          style: TextStyle(color: Colors.black,fontSize: 16),
        ),
      ],
    );
  }
}