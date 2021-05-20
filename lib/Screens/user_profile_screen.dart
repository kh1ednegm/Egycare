import 'package:egycare/components/custom_text_tile.dart';
import 'package:egycare/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  children: [
                    CustomTextTile(title: 'الاسم', value: 'خالد وليد محمود العشماوي',thickness: 1.5,),
                    CustomTextTile(title: 'العنوان', value: 'الشرقية',thickness: 1.5,),
                    CustomTextTile(title: 'تاريخ الميلاد', value: '20-Jan-1999',thickness: 1.5,),
                    CustomTextTile(title: 'الجنس', value: 'ذكر',thickness: 1.5,),
                    CustomTextTile(title: 'رقم الموبايل', value: '01236254796',thickness: 1.5,),

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
                    CustomTextTile(title: 'الاسم',value: 'عمرو خالد حسن',thickness: 1.5,),
                    CustomTextTile(title: 'رقم الموبايل', value: '01124896321',thickness:1.5 ,),
                    CustomTextTile(title: 'الاسم', value: 'عمرو احمد علي',thickness: 1.5,),
                    CustomTextTile(title: 'رقم الموبايل', value: '01234625896',thickness: 0.0,),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }


}


