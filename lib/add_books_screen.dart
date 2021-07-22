import 'package:book_exchange/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AddBooksScreen extends StatefulWidget {
  const AddBooksScreen({Key key}) : super(key: key);

  @override
  _AddBooksScreenState createState() => _AddBooksScreenState();
}

class _AddBooksScreenState extends State<AddBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.backgroundColor,
      child: Column(
        children: [
          Text("Please add some of your books first to start exchanging."),
          GestureDetector(
              child: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                }));
              }),
        ],
      ),
    );
  }
}
