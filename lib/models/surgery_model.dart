class SurgeryModel{
  String title;
  String note;
  String date;

  SurgeryModel({this.title, this.note, this.date});

  SurgeryModel.fromJson(Map<String,dynamic> json){
    title = json['name'];
    note = json['note'];
    date = json['date'];
  }

}