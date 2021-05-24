import 'dart:convert';

import 'package:egycare/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper{


  static saveUserToLocal(UserModel userModel) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user',jsonEncode(userModel));
    print(pref.getString('user'));
  }

  static saveTokenToLocal(String token) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
    print(pref.getString('token'));
  }

  static saveIdToLocal(String id) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('id', id);
    print(pref.get('id'));
  }

  static Future<String> getTokenFromLocal() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    //print(pref.getString('token'));
    return pref.getString('token');
  }

  static Future<UserModel> getUserFromLocal() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.get('user');
    print(user);
    if(user != null){
      print('dDDDDDDDDDDDD');
      UserModel currentUser = UserModel.fromJson(jsonDecode(user));
      print(currentUser);
      print('WWWWWWWWWWWW');
      return UserModel.fromJson(jsonDecode(user));
    }
    else
      return null;
  }

  static Future<String> getIdFromLocal() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    //print(pref.getString('id'));

    return pref.getString('id');
  }

  static deleteUserFromLocal() async{
   SharedPreferences pref = await SharedPreferences.getInstance();
   pref.remove('user');
  }


  static logOut() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('user');
    pref.remove('token');
    pref.remove('id');
  }

}