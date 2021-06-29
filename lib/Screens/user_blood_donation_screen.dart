import 'package:egycare/components/item.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/models/blood_donation_model.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class UserBloodDonationScreen extends StatefulWidget {
  @override
  _UserBloodDonationScreenState createState() =>
      _UserBloodDonationScreenState();
}

class _UserBloodDonationScreenState extends State<UserBloodDonationScreen> {
  Future<List<BloodDonation>> _bloodDonationRequests;

  Future<void> refresh(BuildContext context) async {
    _bloodDonationRequests = NetworkHelper.getBloodDonationRequests();
    setState(() {
      print('The Data : $_bloodDonationRequests');
    });
  }

  @override
  void initState() {
    _bloodDonationRequests = NetworkHelper.getBloodDonationRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refresh(context),
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
                      'طلبات التبرع بالدم',
                      style: kCardTextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              FutureBuilder<List<BloodDonation>>(
                future: _bloodDonationRequests,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'قطرة واحدة منك .. حياة بالنسبة لغيرك',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.06),
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('جاري التحميل'),
                          ),
                        ],
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Expanded(
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
                          TextButton(
                            child: Text('حاول مرة اخري'),
                            onPressed: () async {
                              _bloodDonationRequests =
                                  NetworkHelper.getBloodDonationRequests();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  else if (snapshot.data.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/no_notifications.svg',
                            height: size.height * 0.25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'لا توجد اي اشعارات في الوقت الحالي'),
                          ),
                          TextButton(
                            child: Text('حاول مرة اخري'),
                            onPressed: () async {
                              _bloodDonationRequests =
                                  NetworkHelper.getBloodDonationRequests();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  else {
                    return Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomRow(
                                    title: ' : اسم الحالة',
                                    content: snapshot
                                        .data[snapshot.data.length - index - 1]
                                        .patientName,
                                    icon: FontAwesomeIcons.userAlt,
                                iconColor: kPrimaryColor,),
                                Divider(
                                  thickness: 1,
                                  indent: 24,
                                  endIndent: 24,
                                ),
                                CustomRow(
                                    title: ' : اسم المستشفي',
                                    content: snapshot
                                        .data[snapshot.data.length - index - 1]
                                        .hospital
                                        .name,
                                    icon: FontAwesomeIcons.hospital,
                                iconColor: kPrimaryColor,),
                                Divider(
                                  thickness: 1,
                                  indent: 24,
                                  endIndent: 24,
                                ),
                                ExpansionTile(
                                  children: [
                                    CustomRow(
                                        title: ' : التاريخ',
                                        content: DateFormat('dd-MM-yyyy')
                                            .format(DateTime.parse(snapshot
                                                .data[snapshot.data.length -
                                                    index -
                                                    1]
                                                .date)),
                                        icon: FontAwesomeIcons.calendarCheck,
                                      iconColor: kPrimaryColor,),
                                    Divider(
                                      thickness: 1,
                                      indent: 24,
                                      endIndent: 24,
                                    ),
                                    CustomRow(
                                        title: ' : عدد الاكياس',
                                        content: snapshot
                                            .data[snapshot.data.length -
                                                index -
                                                1]
                                            .numberOfBags,
                                        icon: FontAwesomeIcons.tint,
                                    iconColor: Colors.red,),
                                    Divider(
                                      thickness: 1,
                                      indent: 24,
                                      endIndent: 24,
                                    ),
                                    CustomRow(
                                        title: ' : عنوان المستشفي',
                                        content: snapshot
                                            .data[snapshot.data.length -
                                                index -
                                                1]
                                            .hospital
                                            .location,
                                        icon: FontAwesomeIcons.mapMarkerAlt,
                                      iconColor: kPrimaryColor,),
                                    Divider(
                                      thickness: 1,
                                      indent: 24,
                                      endIndent: 24,
                                    ),
                                    CustomRow(
                                        title: ' : ملاحظات',
                                        content: snapshot
                                            .data[snapshot.data.length -
                                                index -
                                                1]
                                            .note,
                                        icon: FontAwesomeIcons.notesMedical,
                                      iconColor: Colors.red,),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var request = await NetworkHelper.getMedicalHistory();
// print(request);
// if(request == 404){
//   print('الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب الخاص بك');
// }
// else if(request == 0){
//   print('حدث خطأ ما ، حاول مرة اخري');
// }
// else
//   {
//     print(request.surgeries[0].title);
//   }
