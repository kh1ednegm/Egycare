import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class CustomTextFiled extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final InputDecoration inputDecoration;
  final TextInputType inputType;


  CustomTextFiled({this.onChanged, this.inputDecoration,this.inputType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        keyboardType: inputType,
        textAlign:TextAlign.right,
        onChanged: onChanged,
        decoration: inputDecoration,
      ),
    );
  }
}
