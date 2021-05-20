import 'package:flutter/material.dart';



const kPrimaryColor = Color(0xFF0080F6);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kCardTextStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 17,
    color: Color.fromRGBO(63, 63, 63, 1));


class Validator{

 static bool fullName(String name) =>
      RegExp(r'[!@#<>?":_`~;[\]\\|=}/.،<۰۱۲۳٤٥٦٧۸۹>,-\\${+)(*&^%0-9-]').hasMatch(name) || name.isEmpty;

 static bool phoneNumber(String phoneNumber) =>
      !RegExp(r'(^([01]){2}[0-9]{9}$)').hasMatch(phoneNumber) || phoneNumber.isEmpty;

 static bool password(String password) {
  if (password.isEmpty || password.length < 8) {
   return true;
  }
  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  if (hasUppercase) {
   bool hasDigits = password.contains(RegExp(r'[0-9]'));
   if (hasDigits) {
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    if (hasLowercase) {
     bool hasSpecialCharacters = password.contains(
         RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
     return !hasSpecialCharacters;
    }
   }
  }
  return true;
 }

 static bool snn(String snnNumber, String validator) {
  if (snnNumber.length == 14) {
   if (RegExp(r'([0-9]{14})').hasMatch(snnNumber))
    return (!(snnNumber.substring(1, 7) == validator)) || snnNumber.isEmpty;
  }
  else
   return true;
 }



}