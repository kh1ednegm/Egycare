import 'package:egycare/components/custom_textField.dart';
import 'package:egycare/components/date_picker.dart';
import 'package:egycare/components/rounded_button.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class AddDrugs extends StatefulWidget {
  @override
  _AddDrugsState createState() => _AddDrugsState();
}

class _AddDrugsState extends State<AddDrugs> {

  String nameDrug = '';
  String inst = '';
  String firstDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String lastDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.009),
                    Text(
                      'اضافة دواء جديد',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: kPrimaryColor),
                    ),
                    SizedBox(height: size.height * 0.009),
                    CustomTextFiled(
                      inputType: TextInputType.name,
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "أسم الدواء",
                        suffixIcon: Icon(
                          FontAwesomeIcons.capsules,
                          color: kPrimaryColor,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          nameDrug=value;
                        });
                      },
                    ),

                    CustomTextFiled(
                      inputType: TextInputType.name,
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "تعليمات أخد الدواء",
                        suffixIcon: Icon(
                          Icons.article_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          inst=value;
                        });
                      },
                    ),


                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(
                          right: size.width * .06, top: 14, bottom: 14),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Container(
                                child: SingleChildScrollView(
                                  child: MyDatePicker(
                                    initialDate: DateFormat('yyyy-MM-dd')
                                        .parse(firstDate),
                                    onDateTimeChanged: (DateTime date) {
                                      setState(() {
                                        firstDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        // dateTime = DateFormat('yyMMdd')
                                        //     .format(date);
                                      });
                                    },
                                  ),
                                ),
                              ));
                        },
                        child: LayoutBuilder(builder: (context, constrain) {
                          var width = constrain.maxWidth;
                          print(width);
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: width * 0.09),
                                child: Text(
                                  firstDate,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Text(
                                '     بدء أخذ الدواء',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Icon(
                                  FontAwesomeIcons.calendarAlt,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(
                          right: size.width * .06, top: 14, bottom: 14),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Container(
                                child: SingleChildScrollView(
                                  child: MyDatePicker(
                                    initialDate: DateFormat('yyyy-MM-dd')
                                        .parse(lastDate),
                                    onDateTimeChanged: (DateTime date) {
                                      setState(() {
                                        lastDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        // dateTime = DateFormat('yyMMdd')
                                        //     .format(date);
                                      });
                                    },
                                  ),
                                ),
                              ));
                        },
                        child: LayoutBuilder(builder: (context, constrain) {
                          var width = constrain.maxWidth;
                          print(width);
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: width * 0.09),
                                child: Text(
                                  lastDate,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Text(
                                'انتهاء أخذ الدواء  ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Icon(
                                  FontAwesomeIcons.calendarAlt,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    Builder(
                      builder: (BuildContext context)=>RoundedButton(
                        text: "إضافة",
                        press: () async{
                          setState(() {
                            //_showSnnError = Validator.snn(_userSnn, dateTime);
                          });
                          FocusScope.of(context).unfocus();

                          Map<String, dynamic> input = {
                            "id": 0,
                            "name": "string",
                            "instructions": "string",
                            "startDate": "${firstDate}T14:29:05.761Z",
                            "endDate": "${lastDate}T14:29:05.761Z",
                            "medicalHistoryId": 0
                          };


                           await NetworkHelper.addNewMedicine(context,medicine: input);

                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),

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