import 'dart:convert';

import 'package:flutter_application_1/models/popular_mode.dart';
import 'package:http/http.dart' as http;

class CastMoviesApi {
  final dominioUrl = 'https://api.themoviedb.org/3/movie/';
  final keyUrl =
      '/credits?api_key=296e298be8c968bec1cc19a88801cb0a&language=en-US';

  // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  Future<List?> getAllCast(String url) async {
    final result = '$dominioUrl$url$keyUrl';
    //print('EL URL A BUSCAR ES $result');
    final response = await http
        .get(Uri.parse(result)); //we need to convert the url to a uri datatype
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['cast'] as List;
      //print('The size of the result is ${popular.length}');
      if (popular.length != 0) {
        return popular.where((element) => element['order'] <= 10).toList();
      }
      return popular;
    } else {
      return null;
    }
  }
}
