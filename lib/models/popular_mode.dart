// Generated by https://quicktype.io

class PopularModel {
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? title;
  double? voteAverage;
  int? voteCount;

  PopularModel({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  factory PopularModel.fromJSON(Map<String, dynamic> mapMovies) {
    return PopularModel(
      backdropPath: mapMovies['backdrop_path'] ?? '',
      id: mapMovies['id'],
      originalLanguage: mapMovies['original_language'],
      originalTitle: mapMovies['original_title'],
      overview: mapMovies['overview'],
      popularity: mapMovies['popularity'],
      posterPath: mapMovies['poster_path'] ?? '',
      title: mapMovies['title'],
      voteAverage: mapMovies['vote_average'] is int
          ? (mapMovies['vote_average'] as int).toDouble()
          : mapMovies['vote_average'],
      voteCount: mapMovies['vote_count'],
    );
  }
}
