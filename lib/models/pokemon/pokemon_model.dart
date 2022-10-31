class PokemonModel {
  int? id;
  String? numPokedex;
  String? name;
  String? img;
  List? type;
  String? height;
  String? weight;
  List? weaknesses;

  PokemonModel(
      {this.id,
      this.name,
      this.numPokedex,
      this.img,
      this.type,
      this.height,
      this.weight,
      this.weaknesses});

  factory PokemonModel.fromJSON(Map<String, dynamic> mapPokedex) {
    return PokemonModel(
      id: mapPokedex['id'],
      numPokedex: mapPokedex['num'],
      name: mapPokedex['name'] ?? '',
      img: mapPokedex['img'],
      type: mapPokedex['type'],
      height: mapPokedex['height'],
      weight: mapPokedex['weight'] ?? '',
      weaknesses: mapPokedex['weaknesses'],
    );
  }
}
// overview: mapPokedex['overview'],
//       popularity: mapPokedex['popularity'],
//       posterPath: mapPokedex['poster_path'] ?? '',
//       title: mapPokedex['title'],
//       voteAverage: mapPokedex['vote_average'] is int
//           ? (mapPokedex['vote_average'] as int).toDouble()
//           : mapPokedex['vote_average'],
//       voteCount: mapPokedex['vote_count'],