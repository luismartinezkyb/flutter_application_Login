import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/popular_movies_api.dart';
import '../models/popular_mode.dart';

class ListPopularScreen extends StatefulWidget {
  const ListPopularScreen({Key? key}) : super(key: key);

  @override
  State<ListPopularScreen> createState() => _ListPopularScreenState();
}

class _ListPopularScreenState extends State<ListPopularScreen> {
  PopularMoviesApi popularApi = PopularMoviesApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder(
        future: popularApi.getAllPopular(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularModel>?> snapshot) {
          return _listViewPopular(snapshot.data);
        },
      ),
    );
  }

  Widget _listViewPopular(List<PopularModel>? snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(snapshot![index].title!);
      },
    );
  }
}
