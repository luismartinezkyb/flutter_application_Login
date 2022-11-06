import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/provider/theme_pokemon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../api/pokemon_api/fetchAll_pokedex.dart';
import '../../models/pokemon/pokemon_model.dart';

class PageViewPokemonScreen extends StatefulWidget {
  const PageViewPokemonScreen({Key? key}) : super(key: key);

  @override
  State<PageViewPokemonScreen> createState() => _PageViewPokemonScreenState();
}

class _PageViewPokemonScreenState extends State<PageViewPokemonScreen>
    with TickerProviderStateMixin {
  late TabController _tcontrol;
  PokemonListApi pokemonApi = PokemonListApi();
  int numeroPoke = 0;
  String colorFondo = 'normal';

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
  void initState() {
    super.initState();
    _tcontrol = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    //PokemonTheme watch = Provider.of<PokemonTheme>(context);
    //PokemonTheme watch = context.watch<PokemonTheme>();

    final pokeArguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    print(pokeArguments);
    if (pokeArguments.isEmpty) {
      numeroPoke = 0;
    } else {
      numeroPoke = pokeArguments['numeroPoke'] - 1;
      setState(() {
        colorFondo = pokeArguments['type'].toString();
      });
    }
    return FutureBuilder(
      future: pokemonApi.getAllPoke(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PokemonModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _pageViewPokemon(snapshot.data);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('OCURRIO UN ERROR EN LA PETICION'),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _pageViewPokemon(List<PokemonModel>? snapshot) {
    //PokemonTheme watch = Provider.of<PokemonTheme>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return PageView.builder(
        controller: PageController(initialPage: numeroPoke),
        itemCount: snapshot!.length,
        onPageChanged: (index) {
          //watch.setPokemonTheme('${snapshot[index].type![0].toLowerCase()}');
          //watch.setBackgroundColor(value1: '${colours[colorFondo]}');
          // context.read<PokemonTheme>().setBackgroundColor(
          //     value1: '${snapshot[index].type![0].toLowerCase()}');
        },
        itemBuilder: (context, index) {
          return Scaffold(
              backgroundColor: Color(int.parse(
                  '${colours[snapshot[index].type![0].toLowerCase()]}')),
              body: Stack(
                children: [
                  //Arrow Button
                  Positioned(
                    top: 50,
                    left: 5,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, 'newData');
                      },
                    ),
                  ),
                  Positioned(
                      top: 100,
                      left: 20,
                      child: Text(
                        '${snapshot[index].name}',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold)),
                      )),
                  //FONDO POKEBALL
                  //height / 6,
                  Positioned(
                    top: height / 6,
                    right: -130,
                    child: Image.asset(
                      'assets/pokeball_pokedex_api.png',
                      height: 250,
                      fit: BoxFit.fitHeight,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  //CONTAINER Details
                  // TabBar(
                  //     controller: _tcontrol,
                  //     tabs: [
                  //       new Tab(text: 'Info'),
                  //       new Tab(text: 'Stats'),
                  //     ],
                  //   ),
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
                        child:
                            // TabBarView(
                            //   controller: _tcontrol,
                            //   children: [

                            Column(
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
                                      '${snapshot[index].name}',
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
                                      '${snapshot[index].height}',
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
                                      '${snapshot[index].weight}',
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
                                      '#${snapshot[index].numPokedex}',
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
                                      '${snapshot[index].weaknesses!.join(', ')}',
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
                                          'https://www.serebii.net/pokemongo/pokemon/shiny/${snapshot[index].numPokedex}.png',
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
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
                        //AQUI IRIA EL OTRO COLUMN Junto a sus stats de otra api
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                  //POKEMON IMAGE
                  //SHINY https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/${pokemonModel!.id}.png
                  //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemonModel!.id}.png
                  Positioned(
                    top: height / 5.5,
                    left: width / 2.6,
                    child: Hero(
                      tag: '${snapshot[index].name}',
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${snapshot[index].id}.png',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  //TYPES
                  snapshot[index].type!.length == 2
                      ? Positioned(
                          top: 150,
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
                                  border: Border.all(
                                      color: Colors.black, width: .2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color(int.parse(
                                      '${colours[snapshot[index].type![0].toLowerCase()]}')),
                                ),
                                child: Padding(
                                    child: Text(
                                      '${snapshot[index].type![0]}',
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
                                  border: Border.all(
                                      color: Colors.black, width: .2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color(int.parse(
                                      '${colours[snapshot[index].type![1].toLowerCase()]}')),
                                ),
                                child: Padding(
                                    child: Text(
                                      '${snapshot[index].type![1]}',
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
                          top: 150,
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
                              border:
                                  Border.all(color: Colors.black, width: .2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(int.parse(
                                  '${colours[snapshot[index].type![0].toLowerCase()]}')),
                            ),
                            child: Padding(
                                child: Text(
                                  '${snapshot[index].type![0]}',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      textStyle: TextStyle(fontSize: 20.0)),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4)),
                          ),
                        ),
                ],
              ));
        });
  }
}
