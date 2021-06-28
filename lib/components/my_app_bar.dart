import 'package:egycare/constants.dart';
import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
    @required this.size,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      padding: EdgeInsets.only(top: size.height * 0.04),
      decoration: BoxDecoration(
        color: Color(0xFF0080F6),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(23),
            bottomRight: Radius.circular(23)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                child: Image.asset(
                  'assets/icons/logo2bg.png',
                  color: Colors.white,
                  height: size.height * 0.08,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Egycare',
                style: TextStyle(
                    fontFamily: "Diavlo",
                    color: Colors.white,
                    fontSize: 30),
              )
            ],
          ),
          Text(
            title,
            style: kCardTextStyle.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}