import 'package:book_exchange/Custom%20Widgets/google_login_button.dart';
import 'package:book_exchange/login_screen.dart';
import 'package:flutter/material.dart';

import 'Custom Widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: SizedBox(),
            ),
            Container(
              child: Image.asset(
                'images/logo.png',
                scale: 0.8,
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            CustomTextField(
              hintText: "Enter your email.",
              isPassword: false,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Enter a password.",
              isPassword: false,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: GoogleLoginButton(
                  function: () {
                    print("Registration successful.");
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black38),
                  ),
                )
              ],
            ),
            Expanded(flex: 4, child: SizedBox())
          ],
        ),
      ),
    );
  }
}
