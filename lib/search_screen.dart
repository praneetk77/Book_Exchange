import 'package:book_exchange/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Custom Widgets/icon_text_row.dart';
import 'book.dart';
import 'book_screen.dart';
import 'constants.dart';

bool isFresh = true;
bool isLoading = true;
bool startLoading = false;

class SearchScreen extends StatefulWidget {
  List<Book> books;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController inputController = TextEditingController();
  HttpService httpService = HttpService();
  Future getSearchedBooks(String searchQuery) async {
    setState(() {
      isFresh = false;
      isLoading = true;
      startLoading = true;
    });
    widget.books = await httpService.getBooks(searchQuery);
    setState(() {
      isLoading = false;
      startLoading = false;
    });
  }

  @override
  void initState() {
    isFresh = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.lightGrey,
        title: Row(
          children: [
            GestureDetector(
              child: Icon(
                Icons.arrow_back_sharp,
                color: Constants.backgroundColor,
              ),
              onTap: () {
                Navigator.pop(context);
                isFresh = true;
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: TextField(
                  controller: inputController,
                  style: TextStyle(
                      color: Constants.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                  cursorColor: Constants.backgroundColor,
                  cursorHeight: 22,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Constants.backgroundColor.withOpacity(0.7))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Constants.backgroundColor)),
                      hintText: 'Search your book',
                      hintStyle: TextStyle(
                          color: Constants.backgroundColor.withOpacity(0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.search_rounded,
                color: Constants.backgroundColor,
              ),
              onTap: () {
                getSearchedBooks(inputController.text);
              },
            ),
          ],
        ),
      ),
      body: isFresh
          ? Container()
          : isLoading
              ? Container(
                  color: Constants.backgroundColor,
                  child: startLoading
                      ? Column(
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
                                style: TextStyle(
                                    fontSize: 30, color: Constants.lightGrey),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      : Container(),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: widget.books != null
                      ? ListView.builder(
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
                                              image: NetworkImage(
                                                  widget.books[index].imageUrl),
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
                                            (widget.books[index].name.length >
                                                    40)
                                                ? widget.books[index].name
                                                        .substring(0, 39) +
                                                    '...'
                                                : widget.books[index].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, bottom: 10),
                                            child: Text(
                                              (widget.books[index].author
                                                          .length >
                                                      40)
                                                  ? widget.books[index].author
                                                          .substring(0, 39) +
                                                      '...'
                                                  : widget.books[index].author,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.books[index].description,
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
                                          text: widget.books[index].pageCount
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
                                                widget.books[index].isAdded =
                                                    !widget
                                                        .books[index].isAdded;
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
                          })
                      : Center(
                          child: Text(
                            'No results available',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Constants.lightGrey),
                          ),
                        ),
                ),
    );
  }
}
