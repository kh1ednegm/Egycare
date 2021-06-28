import 'package:egycare/Screens/MedicalRecords/user_medical_records_screen.dart';
import 'package:egycare/components/item.dart';
import 'package:egycare/components/my_app_bar.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/models/surgery_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class SurgeriesScreen extends StatelessWidget {
  final List<SurgeryModel> surgeries;
  SurgeriesScreen({@required this.surgeries});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(size: size,title: 'العمليات',),
            SizedBox(
              height: size.height * 0.02,
            ),
            surgeries.isNotEmpty ?
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: surgeries.length,
                itemBuilder: (context, index) {
                  return Container(
                    //elevation: 16,
                    //shadowColor: Colors.white70,
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(23),
                    // ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      children: [
                        CustomRow(
                            title: ': اسم العملية',
                            content: surgeries[surgeries.length - index - 1]
                                .title,
                            icon: FontAwesomeIcons.fileSignature,
                        iconColor: kPrimaryColor,),
                        Divider(
                          thickness: 1,
                          indent: 24,
                          endIndent: 24,
                        ),
                        CustomRow(
                            title: ' :تاريخ الجراجة',
                            content: DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(
                                    surgeries[
                                surgeries.length - index - 1]
                                    .date
                                    )),
                            icon: FontAwesomeIcons.calendarCheck,
                        iconColor: kPrimaryColor,),
                        Divider(
                          thickness: 1,
                          indent: 24,
                          endIndent: 24,
                        ),
                        CustomRow(
                            title: ' : ملاحظات',
                            content:
                                surgeries[surgeries.length - index - 1]
                                .note,
                            icon: FontAwesomeIcons.notesMedical,
                        iconColor: kPrimaryColor,),
                      ],
                    ),
                  );
                },
              ),
            ):
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/gotohospital.svg',
                    height: size.height * 0.25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('الرجاء التوجة لاقرب مستشفي لتفعيل الحساب'),
                  ),
                  TextButton(
                    child: Text('حاول مرة اخري'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserMedicalRecordsScreen()
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
