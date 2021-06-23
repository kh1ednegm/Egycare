
class MedicineModel{

  String medicineName;
  String instructions;
  String startDate;
  String endDate;
  int medicalHistoryId;

  MedicineModel(
      {this.medicineName,
      this.instructions,
      this.startDate,
      this.endDate,
      this.medicalHistoryId});


  MedicineModel.fromJson(Map<String,dynamic> json){
    medicineName = json['name'];
    instructions = json['instructions'];
    startDate = json['start'];
    endDate = json['end'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.medicineName;
    data['instructions'] = this.instructions;
    data['start'] = '${this.startDate}T23:26:33.667Z';
    data['end'] = '${this.endDate}T23:26:33.667Z';
    data['medicalHistoryId'] = this.medicalHistoryId;

    return data;

  }
}