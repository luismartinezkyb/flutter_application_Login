import 'dart:io';

import 'package:flutter_application_1/models/tasks_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
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
        'CREATE TABLE tblTasks(idTask INTEGER PRIMARY KEY, dscTask VARCHAR(100), fechaEntrega DATE)';
    await db.execute(query);
  }

  Future<int> insertTask(Map<String, dynamic> row, String tblName) async {
    var connection = await database;
    return await connection.insert(tblName, row);
  }

  Future<int> updateTask(Map<String, dynamic> row, String tblName) async {
    var connection = await database;
    return await connection
        .update(tblName, row, where: 'idTask = ?', whereArgs: [row['idTask']]);
  }

  Future<int> deleteTask(int idTask, String tblName) async {
    var connection = await database;
    return await connection
        .delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TasksDAO>> getAllTasks() async {
    var connection = await database;
    var result = await connection.query('tblTasks');
    return result.map((mapTask) => TasksDAO.fromJSON(mapTask)).toList();
  }
}
