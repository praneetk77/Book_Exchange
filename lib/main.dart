import 'package:book_exchange/book_screen.dart';
import 'package:book_exchange/loading_screen.dart';
import 'package:book_exchange/main_screen.dart';
import 'package:book_exchange/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'CeraPro'),
      initialRoute: LoginScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
      //TODO: enter various routes
    );
  }
}
