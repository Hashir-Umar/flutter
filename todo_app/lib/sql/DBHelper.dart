import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:todo_app/model/TodoModel.dart';

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

  Future<TodoModel> save(TodoModel todo) async {
    var dbClient = await database;
    todo.id = await dbClient.insert(TODO_TABLE, todo.toMap());
    return todo;
  }

  Future<List<TodoModel>> getTodos() async {
    var dbClient = await database;

    List<Map> maps = await dbClient.transaction((txn) async {
      return await txn.rawQuery('SELECT * FROM $TODO_TABLE where isDone=0');
    });
    List<TodoModel> list = [];
    for (int i = 0; i < maps.length; i++) {
      list.add(TodoModel.fromMap(maps[i]));
    }

    return list;
  }
  
  Future<List<TodoModel>> getTodosCompleted() async {
    var dbClient = await database;

    List<Map> maps = await dbClient.transaction((txn) async {
      return await txn.rawQuery('SELECT * FROM $TODO_TABLE where isDone=1');
    });

    List<TodoModel> list = [];
    for (int i = 0; i < maps.length; i++) {
      list.add(TodoModel.fromMap(maps[i]));
    }

    return list;
  }

  Future<int> delete(int id) async {
    var dbClient = await database;
    return await dbClient.delete(TODO_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<TodoModel> update(TodoModel todo) async {
    var dbClient = await database;
    todo.id = await dbClient.update(TODO_TABLE, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
    return todo;
  }

  Future close() async{
    var dbClient = await database;
    dbClient.close();
  }
}