import 'package:flutter/cupertino.dart';

class Book {
  String name;
  String author;
  String isbn;
  String description;
  String imageUrl;
  bool isAdded;
  int pageCount;

  Book(
      {@required this.name,
      @required this.description,
      @required this.author,
      @required this.imageUrl,
      @required this.pageCount,
      this.isAdded,
      @required this.isbn});
}
