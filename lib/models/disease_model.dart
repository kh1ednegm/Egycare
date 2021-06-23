
class Disease{
  String diseaseTitle;
  int medicalHistoryId;
  String diseaseCause;

  Disease({this.diseaseTitle, this.medicalHistoryId, this.diseaseCause});

  Disease.fromJson(Map<String,dynamic> json){
    diseaseTitle = json['name'];
    medicalHistoryId = json['medicalHistoryId'];
    diseaseCause = json['cause'];
  }

}