import 'package:egycare/Screens/MedicalRecords/user_medical_records_screen.dart';
import 'package:egycare/components/item.dart';
import 'package:egycare/components/my_app_bar.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/models/medical_test_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinch_zoom/pinch_zoom.dart';




class TestsScreen extends StatefulWidget {
  final List<TestModel> tests;
  const TestsScreen({@required this.tests});

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(size: size, title: 'الاختبارات الطبية'),
            SizedBox(
              height: size.height * 0.02,
            ),
            widget.tests.isNotEmpty ?
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.tests.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        CustomRow(
                            title: ' : نوع الاختبار',
                            content: widget
                                .tests[widget.tests.length - index - 1]
                                .title,
                            icon: FontAwesomeIcons.diagnoses,
                        iconColor: kPrimaryColor,),

                        Divider(
                          thickness: 1.5,
                          indent: 24,
                          endIndent: 24,
                        ),
                        CustomRow(
                            title: ': التاريخ',
                            content: DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(widget
                                    .tests[
                                widget.tests.length - index - 1]
                                    .date)),
                            icon: FontAwesomeIcons.calendarCheck,
                        iconColor: kPrimaryColor,),

                        Divider(
                          thickness: 1.5,
                          indent: 24,
                          endIndent: 24,
                        ),
                        Container(
                          height: size.height * .4,
                          width: size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PinchZoom(
                              zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                              resetDuration: const Duration(milliseconds: 100),
                              maxScale: 3,
                                image:CachedNetworkImage(
                                  key: UniqueKey(),
                                  imageUrl: "http://mohamednabiil-001-site1.ctempurl.com/${widget.tests[widget.tests.length - index -1].reportImage}",
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Center(child:CircularProgressIndicator(value: downloadProgress.progress)),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  fit: BoxFit.contain,
                                ) ,
                              ),
                            ),
                          ),
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
