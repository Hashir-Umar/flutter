import 'package:flutter/cupertino.dart';
import 'package:todo_app/todo/TodoModel.dart';

class TodoListProvider extends ChangeNotifier {

  List<TodoModel> _todoList = [];
  List<TodoModel> _todoListCompleted = [];

  List<TodoModel> get todoList => this._todoList;
  List<TodoModel> get todoListCompleted => this._todoListCompleted;

  addTodo(String title, String description) {
    _todoList.add(
      TodoModel(title, description, 0)
    );

    notifyListeners();
  }

  updateTodo(String id, String title, String description) {
    _todoList.removeWhere((element) => element.id == id);
    _todoList.add(
        TodoModel(title, description, 0)
    );

    notifyListeners();
  }

  remove(index) {
    _todoList.removeAt(index);
    print(_todoList.toString());
    notifyListeners();
  }
  
  complete(index) {
    _todoList[index].isDone = 1;
    TodoModel item = _todoList.removeAt(index);
    _todoListCompleted.add(item);
    notifyListeners();
  }
}