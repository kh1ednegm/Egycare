import 'package:egycare/models/user_model.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/material.dart';


class UserBloodDonationScreen extends StatefulWidget {
  @override
  _UserBloodDonationScreenState createState() => _UserBloodDonationScreenState();
}

class _UserBloodDonationScreenState extends State<UserBloodDonationScreen> {

  UserModel user = UserModel('خالد وليد محمود العشماوي', "1999-01-20T14:29:05.761Z", '01014796541', 'ذكر', 'الشرقية', 'حسام حسن', '04865479852', 'ابراهيم حسن', '01478965478');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('ههههههه'),
        onPressed: ()async{
          var request = await NetworkHelper.editPersonalInfo(user: user);
          print(request);
          print(LocalHelper.getUserFromLocal());
        },
      )
    );
  }
}
