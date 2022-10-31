import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/pokemon/pokemon_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/pokemon_api/fetchAll_pokedex.dart';

class AllPokemonScreen extends StatefulWidget {
  const AllPokemonScreen({Key? key}) : super(key: key);

  @override
  State<AllPokemonScreen> createState() => _AllPokemonScreenState();
}

class _AllPokemonScreenState extends State<AllPokemonScreen> {
  PokemonListApi pokemonApi = PokemonListApi();

  final Map<String, dynamic> colours = {
    "normal": '0xFFA8A77A',
    "fire": '0xFFEE8130',
    "water": '0xFF6390F0',
    "electric": '0xFFF7D02C',
    "grass": '0xFF7AC74C',
    "ice": '0xFF96D9D6',
    "fighting": '0xFFC22E28',
    "poison": '0xFFA33EA1',
    "ground": '0xFFE2BF65',
    "flying": '0xFFA98FF3',
    "psychic": '0xFFF95587',
    "bug": '0xFFA6B91A',
    "rock": '0xFFB6A136',
    "ghost": '0xFF735797',
    "dragon": '0xFF6F35FC',
    "dark": '0xFF705746',
    "steel": '0xFFB7B7CE',
    "fairy": '0xFFD685AD',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: pokemonApi.getAllPoke(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PokemonModel>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _gridViewPokemon(snapshot.data);
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('OCURRIO UN ERROR EN LA PETICION'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridViewPokemon(List<PokemonModel>? snapshot) {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.4),
        itemCount: snapshot!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detailPokemon',
                  arguments: snapshot[index]);
              print('${snapshot[index].id}');
            },
            child: Card(
              //A8A77A

              color: Color(int.parse(
                  '${colours[snapshot[index].type![0].toLowerCase()]}')),
              child: Stack(children: [
                Positioned(
                  right: -60,
                  bottom: -10,
                  child: Image.asset(
                    'assets/pokeball_pokedex_api.png',
                    height: 100,
                    fit: BoxFit.fitHeight,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Hero(
                    tag: '${snapshot[index].name}',
                    child: CachedNetworkImage(
                      imageUrl: '${snapshot[index].img}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 85,
                      height: 85,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    '${snapshot[index].name}',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Text(
                    '#${snapshot[index].numPokedex}',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontStyle: FontStyle.italic)),
                  ),
                ),
                snapshot[index].type!.length == 2
                    ? Positioned(
                        top: 65,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.black54),
                              child: Padding(
                                  child: Text(
                                    '${snapshot[index].type![0]}',
                                    style: GoogleFonts.lato(
                                        color: Color(int.parse(
                                            '${colours[snapshot[index].type![0].toLowerCase()]}')),
                                        textStyle: TextStyle(fontSize: 12.0)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4)),
                            ),
                            SizedBox(height: 2),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.black54),
                              child: Padding(
                                  child: Text(
                                    '${snapshot[index].type![1]}',
                                    style: GoogleFonts.lato(
                                        color: Color(int.parse(
                                            '${colours[snapshot[index].type![1].toLowerCase()]}')),
                                        textStyle: TextStyle(fontSize: 12.0)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4)),
                            ),
                          ],
                        ),
                      )
                    : Positioned(
                        top: 90,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.black54),
                          child: Padding(
                              child: Text(
                                '${snapshot[index].type![0]}',
                                style: GoogleFonts.lato(
                                    color: Color(int.parse(
                                        '${colours[snapshot[index].type![0].toLowerCase()]}')),
                                    textStyle: TextStyle(fontSize: 12.0)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4)),
                        ),
                      ),
              ]),
            ),
          );
        });
  }

  appBarWidget() {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text('Pokedex'),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/dash', (route) => false);
        },
      ),
    );
  }
}
