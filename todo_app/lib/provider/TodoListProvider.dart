import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/sql/DBHelper.dart';
import 'package:todo_app/util/DateTimeUtil.dart';

class TodoListProvider extends ChangeNotifier {
  DBHelper _dbHelper;
  List<TodoModel> _todoList = [];
  List<TodoModel> _todoListToday = [];
  List<TodoModel> _todoListCompleted = [];

  List<TodoModel> get todoList => this._todoList;
  List<TodoModel> get todoListToday => this._todoListToday;
  List<TodoModel> get todoListCompleted => this._todoListCompleted;

  static const TODO_TABLE = "Todo";

  TodoListProvider() {
    print("I am here");
    _dbHelper = DBHelper();
    getTodoListToday();
    getTodoList();
    getTodoListCompleted();
  }

  void dispose() async {
    super.dispose();
    _dbHelper.close();
  }

  Future<List<TodoModel>> getTodoListToday() async {
    String currentDate = DateTimeUtil.getCurrentDate();

    try {
      if (_dbHelper != null) {
        List<Map> maps = await _dbHelper
            .fetch('SELECT * FROM $TODO_TABLE where date="$currentDate"');

        print(maps);

        List<TodoModel> list = [];
        for (int i = 0; i < maps.length; i++) {
          list.add(TodoModel.fromMap(maps[i]));
        }

        _todoListToday = list;
      }
    } on Exception catch (exception) {
      _todoListToday = [];
      print(exception.toString());
    }

    notifyListeners();
    return _todoListToday;
  }

  Future<List<TodoModel>> getTodoList() async {
    try {
      if (_dbHelper != null) {
        List<Map> maps =
            await _dbHelper.fetch('SELECT * FROM $TODO_TABLE where isDone=0');

        print(maps);

        List<TodoModel> list = [];
        for (int i = 0; i < maps.length; i++) {
          list.add(TodoModel.fromMap(maps[i]));
        }

        _todoList = list;
      }
    } on Exception catch (exception) {
      _todoList = [];
      print(exception.toString());
    }

    notifyListeners();
    return _todoList;
  }

  Future<List<TodoModel>> getTodoListCompleted() async {
    try {
      if (_dbHelper != null) {
        List<Map> maps =
            await _dbHelper.fetch('SELECT * FROM $TODO_TABLE where isDone=1');

        List<TodoModel> list = [];
        for (int i = 0; i < maps.length; i++) {
          list.add(TodoModel.fromMap(maps[i]));
        }

        _todoListCompleted = list;
      }
    } on Exception catch (exception) {
      _todoListCompleted = [];
      print(exception.toString());
    }
    notifyListeners();
    return _todoListCompleted;
  }

  addTodo(String title, String description, String date, String time) async {
    var todo = await _dbHelper.insert(
        TODO_TABLE, TodoModel(null, title, description, date, time, 0));

    if (date == DateTimeUtil.getCurrentDate()) {
      _todoListToday.add(todo);
    }

    _todoList.add(todo);

    notifyListeners();
  }

  updateTodo(int id, String title, String description, String date, String time,
      int isDone) async {

    var todo = await _dbHelper.update(
        TODO_TABLE, TodoModel(id, title, description, date, time, isDone));

    _todoList.removeWhere((element) => element.id == id);
    _todoList.add(todo);

    updateTodayList();
    notifyListeners();
  }

  remove(id) async {
    await _dbHelper.delete(TODO_TABLE, id);
    _todoList.removeWhere((element) => element.id == id);
    _todoListToday.removeWhere((element) => element.id == id);
    _todoListCompleted.removeWhere((element) => element.id == id);
    updateTodayList();
    notifyListeners();
  }

  complete(id) async {
    int index = _todoList.indexWhere((element) => element.id == id);
    _todoList[index].isDone = 1;
    TodoModel item = _todoList.removeAt(index);
    var todo = await _dbHelper.update(TODO_TABLE, item);
    _todoListCompleted.add(todo);
    updateTodayList();
    notifyListeners();
  }

  void updateTodayList() {
    String currentDate = DateTimeUtil.getCurrentDate();

    _todoListToday.clear();
    _todoList.forEach((element) {
      if(currentDate == element.date) {
        _todoListToday.add(element);
      }
    });
  }
}
