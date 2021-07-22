import 'package:book_exchange/Custom%20Widgets/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'google_sign_in.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      alignment: Alignment.center,
      color: Constants.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.photoURL),
          ),
          Text(
            user.displayName,
            style: TextStyle(color: Constants.lightGrey, fontSize: 20),
          ),
          Text(
            user.email,
            style: TextStyle(color: Constants.lightGrey, fontSize: 20),
          ),
          RoundedButton(
            function: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            text: 'Logout',
          )
        ],
      ),
    );
  }
}
