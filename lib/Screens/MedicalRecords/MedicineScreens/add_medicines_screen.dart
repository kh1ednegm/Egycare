import 'package:egycare/components/custom_textField.dart';
import 'package:egycare/components/date_picker.dart';
import 'package:egycare/components/rounded_button.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/models/medicine_model.dart';
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
  String firstDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String lastDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  bool _showDrugNameError = false,
       _showInstructionError = false;


  bool _valid(){
    return (_showDrugNameError || _showInstructionError);
  }

  bool _isNotEmpty(){
    return nameDrug.isNotEmpty && inst.isNotEmpty;
  }


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
                        errorText: _showDrugNameError ? 'مطلوب' : null,
                        suffixIcon: Icon(
                          FontAwesomeIcons.capsules,
                          color: kPrimaryColor,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          nameDrug=value;
                          value.isEmpty ? _showDrugNameError = true : _showDrugNameError = false;
                        });
                      },
                    ),

                    CustomTextFiled(
                      inputType: TextInputType.name,
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "تعليمات أخد الدواء",
                        errorText: _showInstructionError ? 'مطلوب' : null,
                        suffixIcon: Icon(
                          Icons.article_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          inst=value;
                          value.isEmpty ? _showInstructionError = true : _showInstructionError = false;
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
                                      });
                                    },
                                    maxDate: Duration(days: 0),
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
                                    maxDate: Duration(days: 60),
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
                            nameDrug.isEmpty ? _showInstructionError = true : _showInstructionError = false;
                            inst.isEmpty ? _showInstructionError = true : _showInstructionError = false;
                          });
                          FocusScope.of(context).unfocus();
                          if(!_valid() && _isNotEmpty()){
                            MedicineModel newMedicine = MedicineModel(
                              medicineName:nameDrug,
                              instructions: inst,
                              startDate: firstDate,
                              endDate: lastDate,
                              medicalHistoryId: 0,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                                elevation: 10,
                                content: Text(
                                  '...جاري التحميل',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            );
                            var result = await NetworkHelper.addNewMedicine(medicine: newMedicine.toJson());
                            if(result == 200){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  content: Text(
                                    'تمت العملية بنجاح',
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              );
                            }
                            else if(result == 400){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  content: Text(
                                    'الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب الخاص بك',
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.black,fontSize: 16),
                                  ),
                                ),
                              );
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  content: Text(
                                    'حدث خطأ ما',
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              );
                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                                elevation: 10,
                                content: Text(
                                  'ادخل البيانات بشكل صحيح',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            );
                          }
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