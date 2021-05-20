
class Disease{
  String diseaseTitle;
  String diseaseDescription;
  String diseaseCause;

  Disease({this.diseaseTitle, this.diseaseDescription, this.diseaseCause});

  Disease.fromJson(Map<String,dynamic> json){
    diseaseTitle = json['title'];
    diseaseDescription = json['description'];
    diseaseCause = json['cause'];
  }

}