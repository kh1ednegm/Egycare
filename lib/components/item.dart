import 'package:egycare/constants.dart';
import 'package:flutter/material.dart';


class CustomRow extends StatelessWidget {
  final String title,content;
  final IconData icon;
  final Color iconColor;
  CustomRow({
    @required this.title,
    @required this.content,
    @required this.icon,
    @required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(right:size.width * 0.03,left: size.width * 0.03),
              child: Text(
                content,
                style: TextStyle(
                    color: Color(0xFF3F4F70),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: size.width * 0.02),
            child: Text(
              title,
              maxLines: 3,
              softWrap: true,
              style: TextStyle(
                color: iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: size.width * 0.07,left: size.width * 0.01),
              child: Icon(
                icon,
                color: iconColor,

              )
          ),

        ],
      ),
    );
  }
}