import 'package:egycare/components/rounded_button.dart';
import 'package:egycare/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDatePicker extends StatelessWidget {
  final Function onDateTimeChanged;
  DateTime initialDate;
  MyDatePicker({@required this.onDateTimeChanged,this.initialDate});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.only(right: 20,left: 20,top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Divider(
                color: Colors.grey[300],
                endIndent: size.width * 0.41,
                thickness: 6,
                indent: size.width * 0.41,
              ),
              Divider(color: Colors.grey[300],),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      'تاريخ ميلادك',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.calendarAlt,

                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 170,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100]

                  ),
                  child: CupertinoDatePicker(
                    onDateTimeChanged: onDateTimeChanged,
                    initialDateTime: initialDate,
                    minimumDate: DateTime(1940, 01, 01),
                    maximumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,

                  ),
                ),
              ),
              RoundedButton(
                color: kPrimaryColor,
                  press: (){
                    Navigator.pop(context);
                    },
                  text: 'حسنا',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
