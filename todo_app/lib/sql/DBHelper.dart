import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBHelper {

  static const String DB_NAME = "todo.db";
  static const TODO_TABLE = "Todo";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future initDb() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, DB_NAME);

    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if(_db != null) return _db;

    _db = await initDb();
    return _db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TODO_TABLE (id INTEGER PRIMARY KEY, title TEXT, description TEXT, isDone INTEGER)');
  }


  Future<List<Map>> fetch(String rawQuery) async {
    var dbClient = await database;

    List<Map> maps = await dbClient.transaction((txn) async {
      return await txn.rawQuery(rawQuery);
    });

    return maps;
  }

  Future<dynamic> insert(String tableName, dynamic item) async {
    var dbClient = await database;
    item.id = await dbClient.insert(tableName, item.toMap());
    return item;
  }

  Future<dynamic> update(String tableName, dynamic item) async {
    var dbClient = await database;
    item.id = await dbClient.update(tableName, item.toMap(), where: 'id = ?', whereArgs: [item.id]);
    return item;
  }

  Future<int> delete(String tableName, int id) async {
    var dbClient = await database;
    return await dbClient.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future close() async{
    var dbClient = await database;
    dbClient.close();
  }
}