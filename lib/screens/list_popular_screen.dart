import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

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
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            // Navigator.popUntil(context, (route) => false)
            // Navigator.pop(context, 'newData');
            Navigator.pushNamedAndRemoveUntil(
                context, '/dash', (route) => false);
          },
        ),
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder(
        future: popularApi.getAllPopular(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _listViewPopular(snapshot.data);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('OCURRIO UN ERROR EN LA PETICION'),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _listViewPopular(List<PopularModel>? snapshot) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      padding: EdgeInsets.all(10),
      itemCount: snapshot!.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            FadeInImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${snapshot[index].backdropPath!}'),
              placeholder: AssetImage('assets/loading.gif'),
              fadeInDuration: Duration(milliseconds: 500),
            ),
            Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(.6),
                height: 60,
                child: ListTile(
                  onTap: () {
                    print(snapshot[index]);
                    Navigator.pushNamed(context, '/moviesDetail',
                        arguments: snapshot[index]);
                  },
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  title: Text(
                    snapshot[index].title!,
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white)),
                  ),
                )),
          ]),
        );
      },
    );
  }
}
