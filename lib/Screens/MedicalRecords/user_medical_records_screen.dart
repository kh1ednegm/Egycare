import 'package:egycare/Screens/MedicalRecords/diseases_screen.dart';
import 'package:egycare/Screens/MedicalRecords/MedicineScreens/medicine_screen.dart';
import 'package:egycare/Screens/MedicalRecords/surgeries_screen.dart';
import 'package:egycare/Screens/MedicalRecords/tests_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:egycare/constants.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class UserMedicalRecordsScreen extends StatefulWidget {
  @override
  _UserMedicalRecordsScreenState createState() =>
      _UserMedicalRecordsScreenState();
}

class _UserMedicalRecordsScreenState extends State<UserMedicalRecordsScreen> {

  ImageCache imageCache;
  Future<dynamic> _medicalRecords;

  @override
  void initState() {
    _medicalRecords = NetworkHelper.getMedicalHistory();
    if(imageCache != null){
      print('امسححححححححححححح');
      imageCache.clear();
      imageCache.clearLiveImages();
    }

    super.initState();
  }

  Future<void> refresh(BuildContext context) async {
    _medicalRecords = NetworkHelper.getMedicalHistory();
    setState(() {
      print('The Data : $_medicalRecords');
    });
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refresh(context),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: size.height,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/icons/logo2bg.png',
                            color: Colors.white,
                            height: size.height * 0.1,
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
                  ),
                  FutureBuilder(
                    future: _medicalRecords,
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Expanded(
                          child: Container(
                            width: size.width ,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top:size.height * 0.06),
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('جاري التحميل'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      else if(snapshot.hasError){
                        return Expanded(
                          child: Container(
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
                                TextButton(
                                  child: Text('حاول مرة اخري'),
                                  onPressed: ()async{
                                    _medicalRecords =  NetworkHelper.getMedicalHistory();
                                    setState(() {

                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      else if(snapshot.data == 404){
                        return Expanded(
                          child: Container(
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
                                  'assets/images/gotohospital.svg',
                                  height: size.height * 0.25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب'),
                                ),
                                TextButton(
                                  child: Text('حاول مرة اخري'),
                                  onPressed: ()async{
                                    _medicalRecords =  NetworkHelper.getMedicalHistory();
                                    setState(() {

                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      else
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40))),
                          child: GridView.count(
                            padding: EdgeInsets.only(top: size.height * .1),
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                            primary: false,
                            crossAxisCount: 2,
                            children: <Widget>[
                              CustomCard(
                                imagePath: 'assets/icons/diseases.svg',
                                title: 'الامراض',
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen: DiseasesScreen(diseases: snapshot.data.diseases,),
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              CustomCard(
                                imagePath: 'assets/icons/surgury.svg',
                                title: 'العمليات',
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen: SurgeriesScreen(surgeries: snapshot.data.surgeries,),
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              CustomCard(
                                imagePath: 'assets/icons/tests.svg',
                                title: 'نتائج التحاليل الطبية',
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen: TestsScreen(tests: snapshot.data.tests,),
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              CustomCard(
                                imagePath: 'assets/icons/medicences.svg',
                                title: 'الادوية',
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen: MedicineScreen(medicines: snapshot.data.medicines,),
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class CustomCard extends StatelessWidget {
  final String title, imagePath;
  final Function onTap;


  CustomCard({
    Key key,
    this.title,
    this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey[50],
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              imagePath,
              height: size.height * 0.16,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: kCardTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
