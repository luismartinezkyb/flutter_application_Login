import 'dart:io';

import 'package:flutter_application_1/models/tasks_model.dart';
import 'package:flutter_application_1/models/users_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperUser {
  static final nameDB = 'USERINFO1';
  static final versionDB = 1;
  static final String ID = 'idUser';
  static final String NAME = 'nameUser';
  static final String EMAIL = 'emailUser';
  static final String PHONE = 'phoneUser';
  static final String GITHUB = 'githubUser';
  static final String TABLE = 'userTable';

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
        'CREATE TABLE $TABLE($ID INTEGER, $NAME TEXT, $EMAIL TEXT, $PHONE TEXT, $GITHUB TEXT)';
    await db.execute(query);
  }

  Future<int> save(UserModel user) async {
    print(user);
    var connection = await database;
    return await connection!.insert(TABLE, user.toMap());
  }

  Future<List> getUser() async {
    var connection = await database;
    var result = await connection!.query(TABLE);
    return result;
  }

  Future<int> updateUser(UserModel user) async {
    var connection = await database;
    return await connection!
        .update(TABLE, user.toMap(), where: 'idUser = ?', whereArgs: [0]);
  }
}
