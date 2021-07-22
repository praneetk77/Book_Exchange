import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  IconData icon;
  String text;

  IconTextRow({@required this.icon, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.white),
        )
      ],
    );
  }
}
