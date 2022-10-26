import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/api/videos_movies_api.dart';
import 'package:flutter_application_1/database/database_helper_movie.dart';
import 'package:flutter_application_1/models/popular_mode.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PopularDetailScreen extends StatefulWidget {
  const PopularDetailScreen({Key? key}) : super(key: key);

  @override
  State<PopularDetailScreen> createState() => _PopularDetailScreenState();
}

class _PopularDetailScreenState extends State<PopularDetailScreen> {
  //late VideoPlayerController _controller;
  //late YoutubePlayerController controllerVideo;
  PopularModel? popularModel;
  VideosMoviesApi videosApi = VideosMoviesApi();
  DatabaseHelperMovie? _database;
  bool favorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperMovie();
  }

  @override
  Widget build(BuildContext context) {
    popularModel = ModalRoute.of(context)?.settings.arguments as PopularModel;

    void newMethod() {
      //print('Favorite entra como: $favorite');
      setState(() {
        favorite = !favorite;
      });
      //print('Se acaba de cambiar a: $favorite');
      favorite
          ? _database!.insertMovie({
              'backdrop_path': popularModel!.backdropPath,
              'id': popularModel!.id,
              'original_language': popularModel!.originalLanguage,
              'original_title': popularModel!.originalTitle,
              'overview': popularModel!.overview,
              'popularity': popularModel!.popularity,
              'poster_path': popularModel!.posterPath,
              'title': popularModel!.title,
              'vote_average': popularModel!.voteAverage,
              'vote_count': popularModel!.voteCount,
            }).then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Añadida a favoritos!'),
                  ),
                ),
              })
          : _database!
              .deleteMovie(int.parse('${popularModel!.id}'))
              .then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Eliminada de tus favoritos'),
                      ),
                    ),
                  });
    }

    final futuro = FutureBuilder(
      future: _database!.getMovie(int.parse('${popularModel!.id}')),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //print('El length es de : ${snapshot.data!.length}');
          if (snapshot.data!.isNotEmpty) {
            //print('The data is not empty and is: ${snapshot.data}');
            favorite = true;
            return IconButton(
              icon: Icon(Icons.star_rounded),
              onPressed: () {
                newMethod();
              },
            );
          } else {
            //print('The data is empty then is not favorite the movie');
            favorite = false;
            return IconButton(
              icon: Icon(Icons.star_outline),
              onPressed: () {
                newMethod();
              },
            );
          }
        }
        if (snapshot.hasError) {
          //print('No trae datos, hubo un error');
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      },
    );
    //Era para checar los tipos de datos con los cuales entraban a los metodos
    // print(popularModel!.id.runtimeType);
    // print(int.parse('${popularModel!.id}'));

    final videos = FutureBuilder(
      future: videosApi.getAllVideos('${popularModel!.id}'),
      builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('el tipo de dato es: ${snapshot.data.runtimeType}');
          return CarouselSlider.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              child: Text('${snapshot.data![itemIndex]['key']}'),
            ),
            options: CarouselOptions(height: 200.0),
          );
          //return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          print('has an error');
          return Center(
            child: Text('OCURRIO UN ERROR EN LA PETICION'),
          );
        }
        print('error');
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            // Navigator.popUntil(context, (route) => false)
            // Navigator.pop(context, 'newData');
            Navigator.pushNamedAndRemoveUntil(
                context, '/list', (route) => false);
          },
        ),
        title: Text('${popularModel!.title}'),
        actions: [futuro],
      ),
      body: ListView(physics: BouncingScrollPhysics(), children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.6,
          child: Stack(
            children: [
              Container(
                child: Ink.image(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/original/${popularModel!.backdropPath}'),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 9,
                left: MediaQuery.of(context).size.width / 16,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white54,
                        blurRadius: 3.0,
                        offset: Offset(1, 3),
                        spreadRadius: 0.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500/${popularModel!.posterPath}',
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 3.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(19),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${popularModel!.title}',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: double.parse('${popularModel!.voteAverage}'),
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    itemCount: 10,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${popularModel!.voteAverage}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                          Text('/10', style: TextStyle(color: Colors.black54))
                        ],
                      ),
                      Text('${popularModel!.voteCount}',
                          style: TextStyle(color: Colors.black38, fontSize: 12))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(),
              Text(
                'Overview:',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
              ),
              SizedBox(
                height: 20,
              ),
              ReadMoreText(
                '${popularModel!.overview}',
                style: TextStyle(fontStyle: FontStyle.italic),
                trimLines: 3,
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Trailer',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // CarouselSlider(
              //   options: CarouselOptions(height: 400.0),
              //   items: [1, 2, 3, 4, 5].map((i) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //             width: MediaQuery.of(context).size.width,
              //             margin: EdgeInsets.symmetric(horizontal: 5.0),
              //             decoration: BoxDecoration(color: Colors.amber),
              //             child: Text(
              //               'text $i',
              //               style: TextStyle(fontSize: 16.0),
              //             ));
              //       },
              //     );
              //   }).toList(),
              // ),
            ],
          ),
        ),
        videos,
        SizedBox(height: 30),
      ]),
    );
  }
}

// YoutubePlayerBuilder(
//                 builder: (context, player) => Center(
//                   child: player,
//                 ),
//                 player: YoutubePlayer(
//                   showVideoProgressIndicator: true,
//                   controller: YoutubePlayerController(
//                     initialVideoId: 'r2vFOkemOaY',
//                     flags: YoutubePlayerFlags(loop: false, autoPlay: false),
//                   ),
//                 ),
//               ),