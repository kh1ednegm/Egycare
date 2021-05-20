
class MedicineModel{

  String medicineName;
  String instructions;
  String startDate;
  String endDate;

  MedicineModel(
      {this.medicineName,
      this.instructions,
      this.startDate,
      this.endDate});


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
    data['start'] = this.startDate;
    data['end'] = this.endDate;

    return data;

  }
}