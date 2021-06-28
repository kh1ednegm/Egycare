import 'package:egycare/Screens/ScanCode/scan_results_screen.dart';
import 'package:egycare/Screens/Welcome/welcome_screen.dart';
import 'package:egycare/components/my_app_bar.dart';
import 'package:egycare/components/rounded_button.dart';
import 'package:egycare/services/local_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';



class UserScanScreen extends StatefulWidget {
  @override
  _UserScanScreenState createState() => _UserScanScreenState();
}

class _UserScanScreenState extends State<UserScanScreen> {

  String qrCode;
  var myid ;

  @override
  void initState() {

    super.initState();
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'إلغاء',
        true,
        ScanMode.QR,
      );
      if(qrCode != -1||qrCode!="-1"||qrCode!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PatData(qrCode),));
      }

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }



  @override
  Widget build(BuildContext context) {
    String myId="";
    getmyId()async {
      myId= await LocalHelper.getIdFromLocal();
    }
    getmyId();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            MyAppBar(size: size, title: 'الكود'),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImage(
                data: id??"",
                version: QrVersions.auto,
                size: size.height * 0.5,
              ),
            ),

            SizedBox(height: 8),
            RoundedButton(
              text: "أفحص الكود",
              press:  () => scanQRCode(),
            ),

          ],
        ),
        //child: Text('Scan'),
      ),
    );
  }

}