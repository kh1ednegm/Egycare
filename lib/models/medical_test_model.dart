
class TestModel{

  String title;
  String date;
  String reportImage;

  TestModel({this.title, this.date, this.reportImage});

  TestModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    date = json['date'];
    reportImage = json['reportImage'];
  }
}
