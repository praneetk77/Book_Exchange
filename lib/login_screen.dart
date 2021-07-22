import 'package:book_exchange/Custom%20Widgets/google_login_button.dart';
import 'package:book_exchange/book_screen.dart';
import 'package:book_exchange/google_sign_in.dart';
import 'package:book_exchange/loading_screen.dart';
import 'package:book_exchange/main_screen.dart';
import 'package:book_exchange/sign_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'Custom Widgets/custom_text_field.dart';
import 'constants.dart';
import 'logged_in_widget.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  Widget buildLoading() => Center(
        child: SpinKitWanderingCubes(
          color: Constants.lightGrey,
          size: 60,
        ),
      );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            if (provider.isSigningIn) {
              return widget.buildLoading();
            } else if (snapshot.hasData) {
              return MainScreen();
            } else {
              return SignInWidget();
            }
          },
        ),
      ),
    );
  }
}
