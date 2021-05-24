import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:egycare/models/hospital_model.dart';
import 'package:egycare/models/user_model.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// 10.0.2.2

const DOMAIN = 'http://mohamednabiil-001-site1.ctempurl.com/api/';
const REGISTER_ENDPOINT = DOMAIN + 'ApplicationUser/postUser';
const LOGIN_ENDPOINT = DOMAIN + 'ApplicationUser/Login';
const GET_PERSONAL_INFO_ENDPOINT = DOMAIN + 'PatientProfile/getPatientById/';
const EDIT_PERSONAL_INFO_ENDPOINT = DOMAIN + 'PatientProfile/UpdatePatient/';
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
      {@required String userSnn, @required String password}) async {
    Map<String, dynamic> input = {
      'patientSSN': userSnn,
      'password': password,
    };
    var response = await Helper.post(url: LOGIN_ENDPOINT, body: input);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else
      return 0;
  }


  static Future<UserModel> getPersonalInfoUsingId() async {
    var user = await LocalHelper.getUserFromLocal();
    var token = await LocalHelper.getTokenFromLocal();
    var id = await LocalHelper.getIdFromLocal();

    if (user == null) {
      var response = await Helper.get(
          url: GET_PERSONAL_INFO_ENDPOINT + '${id.toString()}',
          bearerToken: token.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        user = UserModel.fromJson(jsonDecode(response.body));
        LocalHelper.saveUserToLocal(user);
        print('OUTTER USER : $user');
        return user;
      }
      else
        return null;
    }
    else {
      print(user);
      return user;
    }
  }

  static Future<int> editPersonalInfo({@required UserModel user}) async {
    var token = await LocalHelper.getTokenFromLocal();
    var id = await LocalHelper.getIdFromLocal();

    var response = await Helper.put(
        url: EDIT_PERSONAL_INFO_ENDPOINT + '${id.toString()}',
        body: user.toJson(),
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
