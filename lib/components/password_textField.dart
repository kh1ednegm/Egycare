import 'package:egycare/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final bool showPassword;
  final ValueChanged<String> onChanged;
  final InputDecoration inputDecoration;


  PasswordTextField({this.showPassword, this.onChanged, this.inputDecoration});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: showPassword,
        textAlign:TextAlign.right,
        onChanged: onChanged,
        decoration: inputDecoration,

      ),
    );
  }
}
