import 'package:cloud_firestore/cloud_firestore.dart';

import 'book.dart';

class FirestoreService {
  final firestore = FirebaseFirestore.instance;
  var userBooks = [];
  var allBooks = [];

  FirestoreService._constructor();
  static final FirestoreService _instance = FirestoreService._constructor();
  static FirestoreService get instance => _instance;

  void _updateUserBooks(Book book) {
    this.userBooks.add({
      'name': book.name,
      'author': book.author,
      'description': book.description,
      'isbn': book.isbn,
      'imageUrl': book.imageUrl,
      'pageCount': book.pageCount,
    });
  }

  void _updateAllBooks(Book book) {
    this.allBooks.add({
      'name': book.name,
      'author': book.author,
      'description': book.description,
      'isbn': book.isbn,
      'imageUrl': book.imageUrl,
      'pageCount': book.pageCount,
    });
  }

  Future getBooks(String uid) async {
    final books = await firestore.collection('users').doc(uid).get();
    final all = await firestore.collection('all').doc('all-books').get();
    userBooks = books.get('user_books');
    allBooks = all.get('all-books');
  }

  void addBook(Book book, String uid) {
    _updateUserBooks(book);
    _updateAllBooks(book);
    firestore.collection('users').doc(uid).set({'user_books': userBooks});
    firestore.collection('all').doc('all-books').set({'all-books': allBooks});
  }

  List<Book> getBooksList() {
    List<Book> booksList = [];
    for (var book in userBooks) {
      booksList.add(Book(
          name: book['name'],
          author: book['author'],
          isbn: book['isbn'],
          description: book['description'],
          pageCount: book['pageCount'],
          imageUrl: book['imageUrl']));
    }
    return booksList;
  }

  List<Book> getAllBooksList() {
    List<Book> booksList = [];
    for (int i = 1; i < allBooks.length; i++) {
      var book = allBooks[i];
      booksList.add(Book(
          name: book['name'],
          author: book['author'],
          isbn: book['isbn'],
          description: book['description'],
          pageCount: book['pageCount'],
          imageUrl: book['imageUrl']));
    }
    return booksList;
  }
}
