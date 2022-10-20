import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/database/database_helper_movie.dart';
import 'package:flutter_application_1/models/popular_mode.dart';

class FavoritesMoviesScreen extends StatefulWidget {
  const FavoritesMoviesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesMoviesScreen> createState() => _FavoritesMoviesScreenState();
}

class _FavoritesMoviesScreenState extends State<FavoritesMoviesScreen> {
  DatabaseHelperMovie? _database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your favorites movies'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            // Navigator.popUntil(context, (route) => false)
            // Navigator.pop(context, 'newData');
            Navigator.pushNamedAndRemoveUntil(
                context, '/dash', (route) => false);
          },
        ),
      ),
      body: FutureBuilder(
        future: _database!.getAllFavoritesMovies(),
        builder: (context, AsyncSnapshot<List<PopularModel>> snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      height: MediaQuery.of(context).size.height * .15,
                      width: double.infinity,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data![index].title!),
                            subtitle:
                                Text('${snapshot.data![index].popularity!}'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'AQUI IRIAN LAS ACCIONES DE BORRAR DE FAVS, ETC')
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red[100],
                      ));
                },
                itemCount: snapshot.data!.length);
          else if (snapshot.hasError)
            return Center(child: Text('Occurio un errror en la peticion...'));
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
