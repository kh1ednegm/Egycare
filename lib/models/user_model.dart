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
    fullName = json['FullName'];
    print('AND $fullName');
    dateOfBirth = json['dateOfBirth'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    city = json['city'];
    firstRelativeName = json['relativeOneName'];
    firstRelativePhoneNumber = json['relativeOnePhoneNumber'];
    secondRelativeName = json['relativeTwoName'];
    secondRelativePhoneNumber = json['relativeTwoPhoneNumber'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['relativeOneName'] = this.firstRelativeName;
    data['relativeOnePhoneNumber'] = this.firstRelativePhoneNumber;
    data['relativeTwoName'] = this.secondRelativeName;
    data['relativeTwoPhoneNumber'] = this.secondRelativePhoneNumber;

    return data;
  }
}