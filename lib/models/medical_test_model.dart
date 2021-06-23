
class TestModel{

  String title;
  String date;
  String reportImage;
  int medicalHistoryId;

  TestModel({this.title, this.date, this.reportImage,this.medicalHistoryId});

  TestModel.fromJson(Map<String,dynamic> json){
    title = json['name'];
    date = json['date'];
    reportImage = json['image'];
    medicalHistoryId = json['medicalHistoryId'];
  }
}
