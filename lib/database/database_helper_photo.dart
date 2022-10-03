import 'dart:io';

import 'package:flutter_application_1/models/tasks_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/photo_model.dart';

class DatabaseHelperPhoto {
  static final nameDB = 'USERPROFILE2';
  static final versionDB = 1;
  static final String ID = 'id';
  static final String NAME = 'photoName';
  static final String TABLE = 'photosTable';
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
    String query = 'CREATE TABLE $TABLE($ID INTEGER, $NAME TEXT)';
    await db.execute(query);
  }

  Future<int> save(photo photo) async {
    print(photo);
    var connection = await database;
    return await connection!.insert(TABLE, photo.toMap());
  }

  Future<List> getPic(int idPhoto) async {
    var connection = await database;
    //print('GET THE PHOTO $idPhoto');
    var result = await connection!.query(TABLE);
    // result.forEach((element) {
    //   print(element);
    // });
    //print('RESULTADO: $result');
    return result;
  }

  Future<int> updatePhoto(photo photo) async {
    var connection = await database;
    return await connection!
        .update(TABLE, photo.toMap(), where: 'id = ?', whereArgs: [0]);
  }

// Future<int> updateTask(Map<String, dynamic> row) async {
//     var connection = await database;
//     return await connection!
//         .update(TABLE, row, where: 'id = ?', whereArgs: [0]);
//   }

//return result.map((mapTask) => TasksDAO.fromJSON(mapTask)).toList();
  // Future<int> updateUser(Map<String, dynamic> row, String tblName) async {
  //   var connection = await database;
  //   return await connection!
  //       .update(TABLE, row, where: 'id = ?', whereArgs: [row['id']]);
  // }

  // getClient(int id) async {
  //   final db = await database;
  //   var res =await  db.query("Client", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? Client.fromMap(res.first) : Null ;
  // }

}
