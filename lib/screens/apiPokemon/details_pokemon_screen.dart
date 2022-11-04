import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/pokemon/pokemon_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPokemonScreen extends StatefulWidget {
  const DetailPokemonScreen({Key? key}) : super(key: key);

  @override
  State<DetailPokemonScreen> createState() => _DetailPokemonScreenState();
}

class _DetailPokemonScreenState extends State<DetailPokemonScreen> {
  PokemonModel? pokemonModel;

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    pokemonModel = ModalRoute.of(context)?.settings.arguments as PokemonModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(
            int.parse('${colours[pokemonModel!.type![0].toLowerCase()]}')),
        title: Text('Pokemon Info'),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context, 'newData');
          },
        ),
      ),
      backgroundColor:
          Color(int.parse('${colours[pokemonModel!.type![0].toLowerCase()]}')),
      body: Stack(
        children: [
          //Arrow Button
          // Positioned(
          //   top: 45,
          //   left: 1,
          //   child: IconButton(
          //     iconSize: 30,
          //     icon: Icon(Icons.arrow_back),
          //     color: Colors.white,
          //     onPressed: () {
          //       Navigator.pop(context, 'newData');
          //     },
          //   ),
          // ),
          //NAME POSITIONED
          Positioned(
              top: 30,
              left: 20,
              child: Text(
                '${pokemonModel!.name}',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
              )),
          //FONDO POKEBALL
          //height / 6,
          Positioned(
            top: height / 10,
            right: -130,
            child: Image.asset(
              'assets/pokeball_pokedex_api.png',
              height: 250,
              fit: BoxFit.fitHeight,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          //CONTAINER Details
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * .6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    //NOMBRE
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .3,
                            child: Text(
                              'Name',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * .3,
                            child: Text(
                              '${pokemonModel!.name}',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //ALTURA
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .3,
                            child: Text(
                              'Height',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * .3,
                            child: Text(
                              '${pokemonModel!.height}',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //PESO
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .3,
                            child: Text(
                              'Weight',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * .3,
                            child: Text(
                              '${pokemonModel!.weight}',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    //Numero de Pokedex
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .3,
                            child: Text(
                              'Num. Pokedex',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * .3,
                            child: Text(
                              '#${pokemonModel!.numPokedex}',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //DEBILIDADES
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .3,
                            child: Text(
                              'Weakness',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * .5,
                            child: Text(
                              '${pokemonModel!.weaknesses!.join(', ')}',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .3,
                            child: Text(
                              'Shiny Version',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://www.serebii.net/pokemongo/pokemon/shiny/${pokemonModel!.numPokedex}.png',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 130,
                              height: 130,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //POKEMON IMAGE
          //SHINY https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/${pokemonModel!.id}.png
          //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemonModel!.id}.png
          Positioned(
            top: height / 12,
            left: width / 2.6,
            child: Hero(
              tag: '${pokemonModel!.name}',
              child: CachedNetworkImage(
                imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemonModel!.id}.png',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
          ),
          //TYPES
          pokemonModel!.type!.length == 2
              ? Positioned(
                  top: 80,
                  left: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 2.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                          border: Border.all(color: Colors.black, width: .2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(int.parse(
                              '${colours[pokemonModel!.type![0].toLowerCase()]}')),
                        ),
                        child: Padding(
                            child: Text(
                              '${pokemonModel!.type![0]}',
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4)),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 2.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                          border: Border.all(color: Colors.black, width: .2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(int.parse(
                              '${colours[pokemonModel!.type![1].toLowerCase()]}')),
                        ),
                        child: Padding(
                            child: Text(
                              '${pokemonModel!.type![1]}',
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4)),
                      ),
                    ],
                  ),
                )
              : Positioned(
                  top: 80,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      border: Border.all(color: Colors.black, width: .2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(int.parse(
                          '${colours[pokemonModel!.type![0].toLowerCase()]}')),
                    ),
                    child: Padding(
                        child: Text(
                          '${pokemonModel!.type![0]}',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              textStyle: TextStyle(fontSize: 20.0)),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                  ),
                ),
        ],
      ),
    );
  }
}
