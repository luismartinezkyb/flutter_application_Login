import 'dart:io';

import 'package:flutter_application_1/models/tasks_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperUser {
  static final nameDB = 'TAREASBD2';
  static final versionDB = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
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
        'CREATE TABLE tblUser(idUser INTEGER PRIMARY KEY, imageUser TEXT, nameUser VARCHAR(255), emailUser VARCHAR(255), phoneUser VARCHAR(15), githubUser VARCHAR(255))';
    await db.execute(query);
  }

  Future<int> insertUser(Map<String, dynamic> row, String tblName) async {
    var connection = await database;
    return await connection.insert(tblName, row);
  }

  Future<int> updateUser(Map<String, dynamic> row, String tblName) async {
    var connection = await database;
    return await connection
        .update(tblName, row, where: 'idUser = ?', whereArgs: [row['idUser']]);
  }

  Future getUser(int id) async {
    var connection = await database;
    var result =
        await connection.query('tblUser', where: "idUser = ?", whereArgs: [id]);
    print(result);
    return print(result);
  }

  // Future<int> deleteUser(int idTask, String tblName) async {
  //   var connection = await database;
  //   return await connection
  //       .delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  // }

  Future<List<TasksDAO>> getAllTasks() async {
    var connection = await database;
    var result = await connection.query('tblTasks');
    return result.map((mapTask) => TasksDAO.fromJSON(mapTask)).toList();
  }

  // getClient(int id) async {
  //   final db = await database;
  //   var res =await  db.query("Client", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? Client.fromMap(res.first) : Null ;
  // }

}
