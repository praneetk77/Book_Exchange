import 'package:book_exchange/http_service.dart';
import 'package:book_exchange/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'book.dart';
import 'constants.dart';
import 'google_sign_in.dart';

class LoadingScreen extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;
  static final String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.backgroundColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Book> books;
  Book _book1;
  Book _book2;
  Book _book3;
  Book _book4;
  Book _book5;
  HttpService httpService = HttpService();

  Future getBooks() async {
    _book1 = await httpService.getBook('scion of ikshvaku');
    _book2 = await httpService.getBook('the silent patient');
    _book3 = await httpService.getBook('memory man');
    _book4 = await httpService.getBook('angels and demons');
    _book5 = await httpService.getBook('a game of thrones');

    books = [_book1, _book2, _book3, _book4, _book5];

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen();
    }));
  }
}
