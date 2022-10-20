import 'dart:io';

import 'package:flutter_application_1/models/popular_mode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperMovie {
  static final nameDB = 'MOVIES1';
  static final versionDB = 1;
  static final String BACKDROP = 'backdrop_path';
  static final String ID = 'id';
  static final String ORIGINAL_L = 'original_language';
  static final String ORIGINAL_T = 'original_title';
  static final String OVERVIEW = 'overview';
  static final String POPULARITY = 'popularity';
  static final String POSTER = 'poster_path';
  static final String TITLE = 'title';
  static final String VOTE_A = 'vote_average';
  static final String VOTE_C = 'vote_count';

  static final String TABLE = 'moviesTable';
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, nameDB);
    return await openDatabase(
      rutaDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query =
        'CREATE TABLE $TABLE($BACKDROP TEXT, $ID INTEGER, $ORIGINAL_L TEXT, $ORIGINAL_T TEXT, $OVERVIEW TEXT, $POPULARITY DOUBLE,  $POSTER TEXT, $TITLE TEXT,  $VOTE_A DOUBLE,  $VOTE_C INTEGER)';
    await db.execute(query);
  }

  Future<int> insertMovie(Map<String, dynamic> movie) async {
    print('LA PELICULA FAVORITA ES: $movie');
    var connection = await database;
    return await connection!.insert(TABLE, movie);
  }

  Future<int> deleteMovie(int idMovie) async {
    print('SE HA BORRADO LA PEICULA CON EL ID : $idMovie');
    var connection = await database;
    return await connection!
        .delete(TABLE, where: 'id = ?', whereArgs: [idMovie]);
  }

  Future<List<PopularModel>> getAllFavoritesMovies() async {
    var connection = await database;
    var result = await connection!.query(TABLE);
    print('TODAS LAS PELICULAS SON $result');
    return result.map((mapMovie) => PopularModel.fromJSON(mapMovie)).toList();
  }

  //get just one fav movie<Map>
  Future<List> getMovie(int idMovie) async {
    var connection = await database;
    var result =
        await connection!.query(TABLE, where: 'id=?', whereArgs: [idMovie]);
    print('La pelicula arrojada es $result');
    return result;
  }

  // Future<PopularModel?> getMovie2(int idMovie) async {
  //   var connection = await database;
  //   List<Map> maps = await connection!.query(TABLE, where: 'id=?', whereArgs: [idMovie]);
  //   if (maps.length > 0) {
  //     return PopularModel.fromJSON();
  //   }
  //   return null;
  // }

}
