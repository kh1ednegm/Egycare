import 'package:egycare/Screens/MedicalRecords/MedicineScreens/add_medicines_screen.dart';
import 'package:egycare/Screens/MedicalRecords/user_medical_records_screen.dart';
import 'package:egycare/components/item.dart';
import 'package:egycare/components/my_app_bar.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/models/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MedicineScreen extends StatefulWidget {
  final List<MedicineModel> medicines;

  MedicineScreen({@required this.medicines});

  @override
  _MedicineScreenState createState() =>
      _MedicineScreenState();
}

class _MedicineScreenState
    extends State<MedicineScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print('Medicine : ${widget.medicines[0]}');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDrugs(),
            )
          );
        },
        backgroundColor: kPrimaryColor,
        child: Icon(
          FontAwesomeIcons.plus,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              size: size,
              title: 'الادوية',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            widget.medicines.isNotEmpty ?
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.medicines.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      children: [
                        CustomRow(
                            title: ' : اسم الدواء',
                            content: widget
                                .medicines[widget.medicines.length - index - 1]
                                .medicineName,
                            icon: FontAwesomeIcons.capsules,
                            iconColor: kPrimaryColor,),
                        Divider(
                          thickness: 1,
                          indent: 24,
                          endIndent: 24,
                        ),
                        CustomRow(
                            title: ' : بداية من',
                            content: DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(widget
                                    .medicines[
                                widget.medicines.length - index - 1]
                                    .startDate)),
                            icon: FontAwesomeIcons.calendarCheck,
                            iconColor: kPrimaryColor,),
                        Divider(
                          thickness: 1,
                          indent: 24,
                          endIndent: 24,
                        ),
                        CustomRow(
                            title: ' : ينتهي في',
                            content: DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(widget
                                    .medicines[
                                widget.medicines.length - index - 1]
                                    .endDate)),
                            icon: FontAwesomeIcons.calendarCheck,
                        iconColor: kPrimaryColor,),
                        Divider(
                          thickness: 1,
                          indent: 24,
                          endIndent: 24,
                        ),
                        CustomRow(
                            title: ' : التعليمات',
                            content: widget
                                .medicines[widget.medicines.length - index - 1]
                                .instructions,
                            icon: FontAwesomeIcons.notesMedical,
                        iconColor: kPrimaryColor,),
                      ],
                    ),
                  );
                },
              ),
            ) :
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
