class UserModel{

  String fullName;
  var dateOfBirth;
  String phoneNumber;
  String gender;
  String city;
  String firstRelativeName;
  String firstRelativePhoneNumber;
  String secondRelativeName;
  String secondRelativePhoneNumber;

  UserModel(
      this.fullName,
      this.dateOfBirth,
      this.phoneNumber,
      this.gender,
      this.city,
      this.firstRelativeName,
      this.firstRelativePhoneNumber,
      this.secondRelativeName,
      this.secondRelativePhoneNumber,
  );



  UserModel.fromJson(Map<String,dynamic> json){
    print('INNNN');
    fullName = json['fullName'];
    print('AND $fullName');
    dateOfBirth = json['dateOfBirth'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    city = json['city'];
    firstRelativeName = json['realtiveOneName'];
    firstRelativePhoneNumber = json['realtiveOnePhone'];
    secondRelativeName = json['realtiveTwoName'];
    secondRelativePhoneNumber = json['realtiveTwoPhone'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['realtiveOneName'] = this.firstRelativeName;
    data['realtiveOnePhoneNumber'] = this.firstRelativePhoneNumber;
    data['realtiveTwoName'] = this.secondRelativeName;
    data['realtiveTwoPhoneNumber'] = this.secondRelativePhoneNumber;

    return data;
  }
}