

class BloodDonation{

  String patientName;
  String bloodType;
  String numberOfBags;
  String note;
  String date;
  Hospital hospital;

  BloodDonation.fromJson(Map<String,dynamic> json){
    patientName = json['patientName'];
    bloodType = json['bloodType'];
    numberOfBags = json['numberOfBags'];
    note = json['note'];
    date = json['date'];
    hospital = Hospital.fromJson(json['hospital']);

  }

}

class Hospital {

  String name;
  String location;
  String email;

  Hospital.fromJson(Map<String,dynamic> json){
    name = json['name'];
    location = json['location'];
    email = json['email'];
  }
}