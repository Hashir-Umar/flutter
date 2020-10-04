import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/sql/DBHelper.dart';

class TodoListProvider extends ChangeNotifier {
  DBHelper _dbHelper;
  List<TodoModel> _todoList = [];
  List<TodoModel> _todoListCompleted = [];

  List<TodoModel> get todoList => this._todoList;
  List<TodoModel> get todoListCompleted => this._todoListCompleted;

  static const oneSecond = Duration(seconds: 5);

  TodoListProvider() {
    print("I am here");
    _dbHelper = DBHelper();
    getTodoList();
    getTodoListCompleted();
  }

  void dispose() async {
    super.dispose();
    _dbHelper.close();
  }


  Future<void> getTodoList() async {

    try {
      if (_dbHelper != null) {
        _todoList = await _dbHelper.getTodos();
      }
    } on Exception catch (exception) {
      _todoList = [];
      print(exception.toString());
    }

    notifyListeners();
  }

  Future<void> getTodoListCompleted() async {

    try {
      if (_dbHelper != null) {
        _todoListCompleted = await _dbHelper.getTodosCompleted();
      }
    } on Exception catch (exception) {
      _todoListCompleted = [];
      print(exception.toString());
    }

    notifyListeners();
  }


  addTodo(String title, String description) async {
    var todo = await _dbHelper.save(TodoModel(null, title, description, 0));
    _todoList.add(todo);
    notifyListeners();
  }

  updateTodo(int id, String title, String description, int isDone) async {
    var todo = await _dbHelper.update(TodoModel(id, title, description, isDone));
    _todoList.removeWhere((element) => element.id == id);
    _todoList.add(todo);
    notifyListeners();
  }

  remove(id) async {
    var deleteID = await _dbHelper.delete(id);
    _todoList.removeWhere((element) => element.id == deleteID);
    notifyListeners();
  }

  complete(index) async {
    _todoList[index].isDone = 1;
    TodoModel item = _todoList.removeAt(index);
    var todo = await _dbHelper.update(item);
    _todoListCompleted.add(todo);
    notifyListeners();
  }
}
