import 'package:egycare/constants.dart';
import 'package:flutter/material.dart';


class CustomTextTile extends StatelessWidget {

  final String title;
  final String value;
  final double thickness;
  CustomTextTile({
    @required this.title,
    @required this.value,
    this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10,top: 4),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: kCardTextStyle.copyWith(fontSize: 16),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: kCardTextStyle.copyWith(fontSize: 20),
        ),
        Divider(
          indent: 24,
          endIndent: 24,
          thickness: thickness,

        ),

      ],
    );
  }
}