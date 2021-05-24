import 'package:egycare/constants.dart';
import 'package:egycare/models/hospital_model.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class NearestHospitalScreen extends StatefulWidget {
  @override
  _NearestHospitalScreenState createState() => _NearestHospitalScreenState();
}

class _NearestHospitalScreenState extends State<NearestHospitalScreen> with SingleTickerProviderStateMixin{

    AnimationController _controller;
   Animation<Offset> _offsetAnimation;



   @override
  void initState() {
     super.initState();
     _controller = AnimationController(
       duration: const Duration(seconds: 2),
       vsync: this,
     )..repeat(reverse: true);

     _offsetAnimation = Tween<Offset>(
       begin: Offset.zero,
       end: const Offset(0.0, 0.15),
     ).animate(CurvedAnimation(
       parent: _controller,
       curve: Curves.easeIn,
     ));
  }


    @override
    void dispose() {
      super.dispose();
      _controller.dispose();
    }

  @override
  Widget build(BuildContext context) {
     Future<List<Place>> _hospitals = NetworkHelper.getNearestHospitals();
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
                mainAxisSize: MainAxisSize.max,
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
                    'اقرب مستشفي',
                    style: kCardTextStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            FutureBuilder<List<Place>>(
                future: _hospitals,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1,),
                          SlideTransition(
                            position: _offsetAnimation,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child:  SvgPicture.asset(
                                'assets/images/location_search.svg',
                                height: size.height * 0.3,
                              ),
                            ),
                          ),
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
                    );
                  } else if (snapshot.hasError)
                    {
                      _controller.reset();
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
                              onPressed: ()async{
                                _hospitals =  NetworkHelper.getNearestHospitals();
                                setState(() {
                                  _controller.repeat(reverse: true);

                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  else
                    {
                      _controller.reset();
                      return Flexible(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: ()async{
                                    var response = await NetworkHelper.getHospitalDetails(snapshot.data[i].placeId);
                                    showModalBottomSheet(
                                      context: context,
                                      elevation: 3,
                                      builder: (context) => Container(
                                        color: Color(0xFF757575),
                                        child: Container(
                                          height: size.height * 0.25,
                                          padding: EdgeInsets.only(right: 20,left: 20,top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                child: Text(
                                                    '${snapshot.data[i].name}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: size.height * 0.11,
                                                    width: size.width * 0.25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(9)),
                                                      color: Colors.grey[100],
                                                    ),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        FontAwesomeIcons.mapMarkerAlt,
                                                        color: kPrimaryColor,
                                                        size: size.height * 0.09,
                                                      ),
                                                      onPressed: ()async{
                                                        print(response['url']);
                                                        if(await canLaunch(response['url'])){
                                                          await launch(response['url']);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    height: size.height * 0.11,
                                                    width: size.width * 0.25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(9)),
                                                      color: Colors.grey[100],
                                                    ),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        FontAwesomeIcons.phone,
                                                        color: kPrimaryColor,
                                                        size: size.height * 0.09,
                                                      ),
                                                      onPressed: ()async{
                                                        print(response['formatted_phone_number']);
                                                        if(await canLaunch('tel:${response['formatted_phone_number']}')){
                                                          await launch('tel:${response['formatted_phone_number']}');
                                                        }
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06 ),
                                              child: Container(
                                                height: 80.0,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data[i].name}',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '${snapshot.data[i].address}',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      //maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(8),
                                            child: Icon(
                                              FontAwesomeIcons.chevronRight,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        height: 7,
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 5,
                                      ),
                                    ],
                                  ),
                                ) ;
                              }
                          ),
                        ),
                      );
                    }
                })
          ],
        ),
      ),
    );
  }
}



