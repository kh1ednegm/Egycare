class SurgeryModel{
  String title;
  String note;
  String date;
  int medicalHistoryId;
  SurgeryModel({this.title, this.note, this.date,this.medicalHistoryId});

  SurgeryModel.fromJson(Map<String,dynamic> json){
    title = json['name'];
    note = json['type'];
    date = json['date'];
    medicalHistoryId = json['medicalHistoryId'];
  }

}