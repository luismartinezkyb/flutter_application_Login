import 'dart:convert';

import 'package:flutter_application_1/models/popular_mode.dart';
import 'package:http/http.dart' as http;

class VideosMoviesApi {
  final dominioUrl = 'https://api.themoviedb.org/3/movie/';
  final keyUrl =
      '/videos?api_key=296e298be8c968bec1cc19a88801cb0a&language=es-MX';

  // var url = Uri.https('example.com', 'whatsit/create');
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');

  // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  Future<List?> getAllVideos(String url) async {
    final result = '$dominioUrl$url$keyUrl';
    print('EL URL A BUSCAR ES $result');
    final response = await http
        .get(Uri.parse(result)); //we need to convert the url to a uri datatype
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      return popular;
      // List<PopularModel> listPopular =
      //     popular.map((movie) => PopularModel.fromJSON(movie)).toList();
      // return listPopular;
    } else {
      return null;
    }
  }
}
