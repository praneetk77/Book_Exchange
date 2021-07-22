import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  Function function;

  GoogleLoginButton({@required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          highlightColor: Colors.transparent,
          onPressed: function,
          minWidth: 200.0,
          height: 42.0,
          child: Row(
            children: [
              Image.asset(
                'images/google_logo.png',
                scale: 23,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Sign in with Google",
                style: TextStyle(color: Colors.black87, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
