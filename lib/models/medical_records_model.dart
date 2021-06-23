

import 'package:egycare/models/disease_model.dart';
import 'package:egycare/models/medical_test_model.dart';
import 'package:egycare/models/medicine_model.dart';
import 'package:egycare/models/surgery_model.dart';
import 'package:flutter/cupertino.dart';

class MedicalRecords{

  List<Disease> diseases;
  List<MedicineModel> medicines;
  List<SurgeryModel> surgeries;
  List<TestModel> tests;

  MedicalRecords({@required this.diseases,@required this.medicines,@required this.surgeries,@required this.tests,});
}