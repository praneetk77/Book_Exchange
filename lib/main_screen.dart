import 'package:book_exchange/Custom%20Widgets/RoundedButton.dart';
import 'package:book_exchange/add_books_screen.dart';
import 'package:book_exchange/book_screen.dart';
import 'package:book_exchange/firestore_service.dart';
import 'package:book_exchange/search_screen.dart';
import 'package:book_exchange/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'book.dart';
import 'Custom Widgets/icon_text_row.dart';
import 'constants.dart';
import 'google_sign_in.dart';
import 'http_service.dart';

bool isLoading = true;

class MainScreen extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;
  static final String id = "main_screen";
  List<Book> books;
  List<Book> allBooks;
  bool showDrawer = false;

  Widget addedIcon = Icon(
    Icons.add_circle_outline,
    color: Colors.white,
  );

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Book _book1;
  Book _book2;
  Book _book3;
  Book _book4;
  Book _book5;
  HttpService httpService = HttpService();
  FirestoreService firestoreService = FirestoreService.instance;
  Future getBooks() async {
    // _book1 = await httpService.getBook('my grandmother asked me to ');
    // _book2 = await httpService.getBook('the silent patient');
    // _book3 = await httpService.getBook('memory man');
    // _book4 = await httpService.getBook('angels and demons');
    // _book5 = await httpService.getBook('a game of thrones');

    await firestoreService.getBooks(widget.user.uid);

    widget.books = firestoreService.getBooksList();
    widget.allBooks = firestoreService.getAllBooksList();

    setState(() {
      isLoading = false;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getBooks();
  // }

  @override
  Widget build(BuildContext context) {
    getBooks();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        elevation: 5,
        child: Container(
          color: Constants.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 50),
                    child: Container(
                      child: Hero(
                        tag: "user_profile_picture",
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(widget.user.photoURL),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.user.displayName,
                          style: TextStyle(
                              color: Constants.lightGrey, fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.user.email,
                          style: TextStyle(
                              color: Constants.lightGrey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  color: Constants.accentColor,
                  child: TextButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      setState(() {
                        isLoading = true;
                      });
                      provider.logout();
                    },
                    child: Text(
                      "LOGOUT",
                      style:
                          TextStyle(color: Constants.lightGrey, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Container(
              color: Constants.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: SpinKitSquareCircle(
                      color: Constants.lightGrey,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      "Loading...",
                      style:
                          TextStyle(fontSize: 30, color: Constants.lightGrey),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          : Container(
              color: Constants.backgroundColor,
              padding: EdgeInsets.all(10),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                widget.user.displayName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // final provider = Provider.of<GoogleSignInProvider>(
                              //     context,
                              //     listen: false);
                              // provider.logout();
                              _scaffoldKey.currentState.openEndDrawer();
                            },
                            child: Hero(
                              tag: "user_profile_picture",
                              child: Container(
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(widget.user.photoURL),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Text(
                      "My Books",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 245,
                        child: widget.books.length == 0
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Text(
                                          'Your list is empty. Please add some books to start exchanging.',
                                          style: TextStyle(
                                              color: Constants.lightGrey,
                                              fontSize: 20),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Constants.lightGrey,
                                          ),
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SearchScreen();
                                              isLoading = true;
                                            }));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.books.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return BookScreen(widget.books[index]);
                                      }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      width: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(widget
                                                        .books[index].imageUrl),
                                                    fit: BoxFit.fill)),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            (widget.books[index].name.length >
                                                    30)
                                                ? widget.books[index].name
                                                        .substring(0, 29) +
                                                    '...'
                                                : widget.books[index].name,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Books",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchScreen();
                              }));
                            }),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: widget.allBooks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BookScreen(widget.allBooks[index]);
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                height: 150,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(widget
                                                  .allBooks[index].imageUrl),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (widget.allBooks[index].name
                                                        .length >
                                                    40)
                                                ? widget.allBooks[index].name
                                                        .substring(0, 39) +
                                                    '...'
                                                : widget.allBooks[index].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, bottom: 10),
                                            child: Text(
                                              (widget.allBooks[index].author
                                                          .length >
                                                      40)
                                                  ? widget.allBooks[index]
                                                          .author
                                                          .substring(0, 39) +
                                                      '...'
                                                  : widget
                                                      .allBooks[index].author,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget
                                                  .allBooks[index].description,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconTextRow(
                                          icon: Icons.menu_book_outlined,
                                          text: widget.allBooks[index].pageCount
                                              .toString(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.white,
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                widget.allBooks[index].isAdded =
                                                    !widget.allBooks[index]
                                                        .isAdded;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
