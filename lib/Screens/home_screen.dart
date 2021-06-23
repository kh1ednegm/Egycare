import 'package:egycare/Screens/ScanCode/scan_code_screen.dart';
import 'package:egycare/Screens/nearest_hospital_screen.dart';
import 'package:egycare/Screens/user_blood_donation_screen.dart';
import 'package:egycare/Screens/MedicalRecords/user_medical_records_screen.dart';
import 'package:egycare/Screens/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class HomeScreen extends StatelessWidget {

  HomeScreen({Key key}) : super(key: key);
  PersistentTabController _controller = PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      UserProfileScreen(),
      UserBloodDonationScreen(),
      UserScanScreen(),
      NearestHospitalScreen(),
      UserMedicalRecordsScreen(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_rounded,size: 20,),
        title: ("الملف"),
        textStyle: TextStyle(fontSize: 11),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.handHoldingHeart,size: 20,),
        title: ("التبرع"),
        textStyle: TextStyle(fontSize: 11),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.qrcode,color: Colors.white,size: 25,),
        title: ("QR Code"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.hospital,size: 20,),
        title: ("مستشفيات"),
        textStyle: TextStyle(fontSize: 11),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.fileMedical,size: 20,),
        title: ("السجل الطبي"),
        textStyle: TextStyle(fontSize: 11),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.grey[100],// Default is Colors.white.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.// Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}


