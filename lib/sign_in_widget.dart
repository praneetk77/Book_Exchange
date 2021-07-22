import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Custom Widgets/google_login_button.dart';
import 'constants.dart';
import 'google_sign_in.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.backgroundColor,
        // image: DecorationImage(
        //     image: AssetImage('images/wall.png'), fit: BoxFit.cover),
      ),
      child: Padding(
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
            Center(
                child: Text(
              "Book Exchange",
              style: TextStyle(color: Constants.lightGrey, fontSize: 30),
            )),
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            GoogleLoginButton(
              function: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.login();
              },
            ),
            Expanded(
              child: SizedBox(),
              flex: 7,
            )
          ],
        ),
      ),
    );
  }
}
