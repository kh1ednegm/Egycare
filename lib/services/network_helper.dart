import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:egycare/models/blood_donation_model.dart';
import 'package:egycare/models/disease_model.dart';
import 'package:egycare/models/hospital_model.dart';
import 'package:egycare/models/medical_records_model.dart';
import 'package:egycare/models/medical_test_model.dart';
import 'package:egycare/models/medicine_model.dart';
import 'package:egycare/models/surgery_model.dart';
import 'package:egycare/models/user_model.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// 10.0.2.2

const DOMAIN = 'http://mohamednabiil-001-site1.ctempurl.com/api/';
const REGISTER_ENDPOINT = DOMAIN + 'ApplicationUser/postUser';
const LOGIN_ENDPOINT = DOMAIN + 'ApplicationUser/Login';
const GET_PERSONAL_INFO_ENDPOINT = DOMAIN + 'PatientProfile/getPatientById/';
const EDIT_PERSONAL_INFO_ENDPOINT = DOMAIN + 'PatientProfile/UpdatePatient/';
const ADD_NEW_MEDICINE = DOMAIN + 'Medicines/PostMedicine/';
const GET_MEDICAL_RECORDS = DOMAIN + 'MedicalHistories/GetMedicalHistory/';
const GET_BLOOD_DONATION_REQUESTS = DOMAIN + 'Notifications/Get/';

const mapsKey = 'AIzaSyBxTpTVqAy_Aq_qhkv5wwjLz5g1WWZQxNg';

class NetworkHelper {


  static Future<int> register({@required Map<String, dynamic> input}) async {
    var response = await Helper.post(url: REGISTER_ENDPOINT, body: input,);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return 200;
    }
    else if (response.statusCode == 400) {
      return 400;
    }
    else
      return 0;
  }

  static Future<dynamic> login(
      {@required String userSnn, @required String password, @required String deviceToken}) async {
    Map<String, dynamic> input = {
      'patientSSN': userSnn,
      'password': password,
      'deviceToken': deviceToken,
    };
    var response = await Helper.post(url: LOGIN_ENDPOINT, body: input);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else
      return 0;
  }

  static Future<UserModel> getPersonalInfoUsingId([String idPat]) async {
    var user = await LocalHelper.getUserFromLocal();
    var token = await  LocalHelper.getTokenFromLocal();
    var id = await LocalHelper.getIdFromLocal();



    var response = await Helper.get(url: GET_PERSONAL_INFO_ENDPOINT + '${idPat==null?id.toString():idPat}', bearerToken: token.toString());
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      user = UserModel.fromJson(jsonDecode(response.body));
      LocalHelper.saveUserToLocal(user);
      print('OUTTER USER : $user');
      return UserModel.fromJson(jsonDecode(response.body));

    }
    else
    {
      print(user);
      return UserModel.fromJson(jsonDecode(response.body));
    }
  }

  static Future<int> editPersonalInfo({@required UserModel user}) async {
    var token = await LocalHelper.getTokenFromLocal();
    var id = await LocalHelper.getIdFromLocal();

    var response = await Helper.put(
        url: EDIT_PERSONAL_INFO_ENDPOINT + '${id.toString()}',
        body: {
          "phoneNumber": user.phoneNumber,
          "city": user.city,
          "relativeOneName": user.firstRelativeName,
          "relativeOnePhoneNumber": user.firstRelativePhoneNumber,
          "relativeTwoName": user.secondRelativeName,
          "relativeTwoPhoneNumber": user.secondRelativePhoneNumber,


        },
        bearerToken: token.toString());
    print(response.statusCode);
    if (response.statusCode == 200) {
      LocalHelper.deleteUserFromLocal();
      LocalHelper.saveUserToLocal(user);
      return 200;
    }
    else if (response.statusCode == 400) {
      return 400;
    }
    else
      return 0;
  }

  // static Future<dynamic> addNewMedicine({@required Map<String,dynamic> medicine}) async {
  //   var id = await LocalHelper.getIdFromLocal();
  //   var token = await LocalHelper.getTokenFromLocal();
  //
  //   var response = await Helper.post(url: ADD_NEW_MEDICINE + '${id.toString()}',
  //       body: medicine, bearerToken: token.toString());
  //   print(response.statusCode);
  //   var result;
  //   if(response.body.isNotEmpty)
  //     result = jsonDecode(response.body);
  //   if(response.statusCode == 200){
  //     print(response.body);
  //     return 200;
  //   }
  //   else if(response.statusCode == 400 && result == 'There is no medical history for this Patient'){
  //     return 'الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب الخاص بك';
  //   }
  //   else
  //     return 0;
  // }

  static Future<dynamic> addNewMedicine(context,
      {@required Map<String, dynamic> medicine}) async {
    var id = await LocalHelper.getIdFromLocal();
    var token = await LocalHelper.getTokenFromLocal();
    print("print in data");
// var x={
//   "id": id,
//   "name": "string",
//   "instructions": "string",
//   "startDate": "2021-06-25T11:32:31.994Z",
//   "endDate": "2021-06-25T11:32:31.994Z",
//   "medicalHistoryId": 0
// };

    var response = await Helper.post(url: ADD_NEW_MEDICINE + '${id.toString()}',
        body: medicine, bearerToken: token.toString());
    print("it done" + response.statusCode.toString());
    var result;
    if (response.body.isNotEmpty)
      result = jsonDecode(response.body);


    print(result.toString());
    if (response.statusCode == 200) {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم اضافة الدواء بنجاح")));

      return 200;
    }
    else if (response.statusCode == 400 &&
        result == 'There is no medical history for this Patient') {
      ScaffoldMessenger
          .of(context)
          .showSnackBar(SnackBar(content: Text(


          " الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب الخاص بك"

      )));

      return 'الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب الخاص بك';
    }
    else
      return 0;
  }

  static Future<dynamic> getMedicalHistory() async{
    var id = await LocalHelper.getIdFromLocal();
    var token = await LocalHelper.getTokenFromLocal();

    var response = await Helper.get(url: GET_MEDICAL_RECORDS + '${id.toString()}', bearerToken: token.toString());
    print(response.statusCode);
    var result = jsonDecode(response.body);
    print(result);
    if(response.statusCode == 200){
      return MedicalRecords(
        diseases: (result['diseases'] as List).map((disease) => Disease.fromJson(disease)).toList(),
        medicines: (result['medicines'] as List).map((medicine) => MedicineModel.fromJson(medicine)).toList(),
        surgeries: (result['operations'] as List).map((surgery) => SurgeryModel.fromJson(surgery)).toList(),
        tests: (result['tests'] as List).map((test) => TestModel.fromJson(test)).toList(),
      );
    }
    else if(response.statusCode == 404 && result == 'This user doesn\'t have any medical history yet.'){
      return 404;
    }
    else
      return 0;
  }

  static Future<List<BloodDonation>> getBloodDonationRequests() async{

    var id = await LocalHelper.getIdFromLocal();
    var token = await LocalHelper.getTokenFromLocal();

    var response = await Helper.get(url: GET_BLOOD_DONATION_REQUESTS + '${id.toString()}', bearerToken: token.toString());
    print(id.toString());
    print(response.statusCode);
    var result;

    if(response.statusCode == 200 && response.body.isNotEmpty){
      result = jsonDecode(response.body);
      print(response.body);
      return (result as List).map((bloodDonation) => BloodDonation.fromJson(bloodDonation)).toList();
    }
    else
      return null;
  }

  static Future<List<Place>> getNearestHospitals() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var lng = position.longitude;
    http.Response response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=hospital&rankby=distance&opennow&keyword=المستشفي%20الحكومي&language=ar&key=$mapsKey'));
    var json = jsonDecode(response.body);
    var results = json['results'];
    List<Place> hospitals = [];
    for (var hospital in results) {
      Place place = Place(name: hospital['name'],
        address: hospital['vicinity'],
        placeId: hospital['place_id'],);
      hospitals.add(place);
    }
    return hospitals;
  }

  static Future<dynamic> getHospitalDetails(String placeId)async{

    http.Response response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=formatted_phone_number,url&key=$mapsKey'));
    print(response.statusCode);
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      return json['result'];
    }
    else return 0;

  }



}

class Helper{

  static Future<http.Response> post( {@required String url, @required Map<String, dynamic> body,
    String bearerToken}) async {

    return await http.post(Uri.parse(url), body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader : 'Bearer $bearerToken',
        }
    );
  }

  static Future<http.Response> put({@required String url, @required Map<String,dynamic> body,
    @required String bearerToken}) async{
    return await http.put(Uri.parse(url),body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader : 'Bearer $bearerToken',
        });
  }

  static Future<http.Response> get({@required String url, @required String bearerToken}){

    return http.get(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader : 'Bearer $bearerToken',
        });
  }
}
