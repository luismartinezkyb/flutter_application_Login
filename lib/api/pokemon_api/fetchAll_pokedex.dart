import 'dart:convert';

import 'package:flutter_application_1/models/pokemon/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonListApi {
  final url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  Future<List<PokemonModel>?> getAllPoke() async {
    final response = await http
        .get(Uri.parse(url)); //we need to convert the url to a uri datatype
    if (response.statusCode == 200) {
      var pokemones = jsonDecode(response.body)['pokemon'] as List;
      List<PokemonModel> listPokes =
          pokemones.map((poke) => PokemonModel.fromJSON(poke)).toList();
      return listPokes;
    } else {
      return null;
    }
  }
}
