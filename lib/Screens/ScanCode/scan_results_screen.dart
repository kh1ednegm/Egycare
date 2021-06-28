

import 'package:egycare/models/user_model.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:egycare/components/custom_text_tile.dart';
import 'package:egycare/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PatData extends StatelessWidget {
  final String userId;

  PatData(this.userId);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
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
                    'نتيجة الفحص',
                    style: kCardTextStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            FutureBuilder(
              future: NetworkHelper.getPersonalInfoUsingId(userId),
              builder: (context, snapshot) {
              print(userId);
              if(snapshot.hasError){
                return Expanded(
                  child: Column(
                    children: [
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
                            Text('حاول مرة اخري'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              else if(snapshot.hasData){
                UserModel userModel= snapshot.data;
                print(snapshot.data);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Column(
                        children: [
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
                          CustomTextTile(title: 'الاسم', value: userModel.fullName,thickness: 1.5,),
                          CustomTextTile(title: 'القريب الأول', value: userModel.firstRelativeName,thickness: 1.5,),
                          CustomTextTile(title: 'رقم الموبايل', value: userModel.firstRelativePhoneNumber,thickness: 1.5,),
                          CustomTextTile(title: 'القريب الثاني', value: userModel.secondRelativeName,thickness: 1.5,),
                          CustomTextTile(title: 'رقم الموبايل', value: userModel.secondRelativePhoneNumber,thickness: 1.5,),
                        ],

                      ),
                    ),
                  ],
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },),
          ],
        ),
      ),);
  }
}