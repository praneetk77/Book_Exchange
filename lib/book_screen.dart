import 'package:book_exchange/Custom%20Widgets/google_login_button.dart';
import 'package:book_exchange/firestore_service.dart';
import 'package:book_exchange/http_service.dart';
import 'package:book_exchange/login_screen.dart';
import 'package:book_exchange/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'Custom Widgets/RoundedButton.dart';
import 'Custom Widgets/custom_text_field.dart';
import 'constants.dart';

HttpService httpService = HttpService();

class BookScreen extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;
  static final String id = 'book_screen';
  final Book book1;

  BookScreen(this.book1);

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final firestore = FirebaseFirestore.instance;
  final firestoreService = FirestoreService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                child: Icon(Icons.arrow_back_sharp),
                onTap: () {
                  Navigator.pop(context);
                }),
            Icon(Icons.more_horiz),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.darken),
                  image: NetworkImage(widget.book1.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 800,
                    ),
                    flex: 7,
                  ),
                  Text(
                    (widget.book1.name.length > 30)
                        ? widget.book1.name.substring(0, 29) + '...'
                        : widget.book1.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Container(
                    height: 200,
                    child: Image(image: NetworkImage(widget.book1.imageUrl)),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Text(
                    widget.book1.author,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Container(
                    width: 350,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        color: Colors.black87.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        elevation: 5.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.book1.pageCount.toString(),
                                  style: TextStyle(color: Constants.lightGrey),
                                ),
                                Text(
                                  "  Pages ",
                                  style: TextStyle(color: Constants.lightGrey),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: 5,
                              height: 60,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "4.5",
                                  style: TextStyle(color: Constants.lightGrey),
                                ),
                                Text(
                                  " Rating ",
                                  style: TextStyle(color: Constants.lightGrey),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: 5,
                              height: 60,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Eng",
                                  style: TextStyle(color: Constants.lightGrey),
                                ),
                                Text(
                                  "Language",
                                  style: TextStyle(color: Constants.lightGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(5),
              color: Constants.backgroundColor,
              height: 278,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(),
                    flex: 3,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontFamily: 'CeraPro'),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 15,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.book1.description,
                        style: TextStyle(
                            fontSize: 16,
                            color: Constants.lightGrey,
                            fontFamily: 'CeraPro'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 2,
                  ),
                  Center(
                    child: RoundedButton(
                      text: "Add to Collection",
                      buttonColor: Constants.accentColor,
                      textColor: Colors.white,
                      function: () {
                        firestoreService.addBook(widget.book1, widget.user.uid);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
