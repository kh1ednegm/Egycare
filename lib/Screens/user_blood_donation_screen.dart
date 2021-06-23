import 'package:egycare/models/medicine_model.dart';
import 'package:egycare/models/user_model.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:egycare/services/network_helper.dart';
import 'package:flutter/material.dart';


class UserBloodDonationScreen extends StatefulWidget {
  @override
  _UserBloodDonationScreenState createState() => _UserBloodDonationScreenState();
}

class _UserBloodDonationScreenState extends State<UserBloodDonationScreen> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('ههههههه'),
        onPressed: ()async{
          MedicineModel medicineModel = MedicineModel(medicalHistoryId:0,instructions: '3 مرات ف اليوم لمدة اسبوع',
              medicineName: 'كونجستال', startDate: '2021-06-23',endDate: '2021-07-23');
          var request = await NetworkHelper.addNewMedicine(medicine: medicineModel.toJson());
          print(request);

        },
      )
    );
  }
}


// var request = await NetworkHelper.getMedicalHistory();
// print(request);
// if(request == 404){
//   print('الرجاء التوجة الي اقرب مستشفي لتفعيل الحساب الخاص بك');
// }
// else if(request == 0){
//   print('حدث خطأ ما ، حاول مرة اخري');
// }
// else
//   {
//     print(request.surgeries[0].title);
//   }