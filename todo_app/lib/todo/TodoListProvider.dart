import 'package:flutter/cupertino.dart';
import 'package:todo_app/todo/TodoModel.dart';

class TodoListProvider extends ChangeNotifier {

  List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => this._todoList;

  addTodo(String title, String description) {
    _todoList.add(
      TodoModel(title, description, 0)
    );

    notifyListeners();
  }
}