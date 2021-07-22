import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String text;
  Color buttonColor = Colors.white;
  Color textColor = Colors.black87;
  Function function;

  RoundedButton(
      {@required this.text,
      @required this.function,
      this.buttonColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
            highlightColor: Colors.transparent,
            onPressed: function,
            minWidth: 100.0,
            height: 42.0,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 18),
            )),
      ),
    );
  }
}
