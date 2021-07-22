import 'book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  final String url = "https://www.googleapis.com/books/v1/volumes?q=";

  Future<Book> getBook(String searchQuery) async {
    searchQuery = searchQuery.trim();
    List<String> search = searchQuery.split(' ');
    String searchString = '';
    for (String e in search) {
      searchString += (e + '+');
    }
    searchString = searchString.substring(0, searchString.length - 1);
    http.Response response = await http.get(Uri.parse(url + searchString));
    String data = response.body;

    var bookName =
        jsonDecode(data)['items'][0]['volumeInfo']['title'] as String;
    var authorName =
        jsonDecode(data)['items'][0]['volumeInfo']['authors'][0] as String;
    var bookDescription =
        jsonDecode(data)['items'][0]['volumeInfo']['description'] as String;
    var imageUrl = jsonDecode(data)['items'][0]['volumeInfo']['imageLinks']
        ['thumbnail'] as String;
    var isbn = jsonDecode(data)['items'][0]['volumeInfo']['industryIdentifiers']
        [0]['identifier'] as String;
    var pageCount =
        jsonDecode(data)['items'][0]['volumeInfo']['pageCount'] as int;
    var isAdded = false;

    return Book(
        isAdded: isAdded,
        description: bookDescription,
        author: authorName,
        imageUrl: imageUrl,
        name: bookName,
        pageCount: pageCount,
        isbn: isbn);
  }

  Future<List<Book>> getBooks(String searchQuery) async {
    searchQuery = searchQuery.trim();
    List<String> search = searchQuery.split(' ');
    String searchString = '';
    for (String e in search) {
      searchString += (e + '+');
    }
    searchString = searchString.substring(0, searchString.length - 1);
    http.Response response = await http.get(Uri.parse(url + searchString));
    String data = response.body;

    List<Book> books = [];

    var numberOfResults = jsonDecode(data)['totalItems'] as int;

    if (numberOfResults == 0) {
      return null;
    } else {
      for (int i = 0; i < 10; i++) {
        var bookName =
            jsonDecode(data)['items'][i]['volumeInfo']['title'] as String;
        var authorName;
        try {
          authorName = jsonDecode(data)['items'][i]['volumeInfo']['authors'][0]
              as String;
        } catch (_) {
          authorName = 'Not Available';
        }
        var bookDescription;
        try {
          bookDescription = jsonDecode(data)['items'][i]['volumeInfo']
              ['description'] as String;
        } catch (_) {
          bookDescription = 'Not Available';
        }
        var imageUrl;
        try {
          imageUrl = jsonDecode(data)['items'][i]['volumeInfo']['imageLinks']
              ['thumbnail'] as String;
        } catch (_) {
          imageUrl =
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/488px-No-Image-Placeholder.svg.png';
        }
        var isbn;
        try {
          isbn = jsonDecode(data)['items'][i]['volumeInfo']
              ['industryIdentifiers'][0]['identifier'] as String;
        } catch (_) {
          isbn = 'Not Available';
        }
        var pageCount;
        try {
          pageCount =
              jsonDecode(data)['items'][i]['volumeInfo']['pageCount'] as int;
        } catch (_) {
          pageCount = 0;
        }
        var isAdded = false;

        books.add(
          Book(
              isAdded: isAdded,
              description:
                  bookDescription == null ? 'Not available' : bookDescription,
              author: authorName == null ? 'Not available' : authorName,
              imageUrl: imageUrl,
              name: bookName,
              pageCount: pageCount == null ? 0 : pageCount,
              isbn: isbn == null ? 'Not available' : isbn),
        );
      }
      return books;
    }
  }
}
