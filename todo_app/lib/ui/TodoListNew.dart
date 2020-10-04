import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:todo_app/todo/TodoModel.dart';
import 'package:todo_app/ui/TodoCreateUpdate.dart';

class TodoListNew extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    return Container(
      child: Consumer<TodoListProvider>(
        builder: (context, todo, child) {
          return Stack(
            children: [
              todo.todoList.length == 0
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.trending_down),
                          onPressed: () {},
                          iconSize: 50.0,
                          color: Colors.grey,
                        ),
                        Text(
                          "Nothing to do",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: todo.todoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            try {
                              TodoModel result = await Get.to(
                                  TodoCreateUpdate(),
                                  arguments: TodoModel(
                                      todo.todoList[index].title,
                                      todo.todoList[index].description,
                                      todo.todoList[index].isDone));
                              Provider.of<TodoListProvider>(context)
                                  .updateTodo(todo.todoList[index].id, result.title, result.description);
                            } on NoSuchMethodError catch (exception) {
                              print("Back button called with no input added");
                            }
                          },
                          title: Text(
                            "${todo.todoList[index].title}",
                          ),
                          subtitle: Text(
                            "${todo.todoList[index].description}",
                          ),
                          onLongPress: () async {
                            showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete ?'),
                                    content: Text(
                                        'Are you sure you want to remove this todo?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Yes'),
                                        textColor: Colors.green,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Provider.of<TodoListProvider>(
                                                  mContext)
                                              .remove(index);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('No'),
                                        textColor: Colors.red,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          focusColor: Colors.deepPurple,
                          leading: IconButton(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            onPressed: () {},
                          ),
                          trailing: Checkbox(
                            value: todo.todoList[index].isDone == 1,
                            onChanged: (bool value) {
                              Provider.of<TodoListProvider>(context)
                                  .complete(index);
                            },
                          ),
                          selected: todo.todoList[index].isDone == 1,
                        );
                      },
                    ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 16, bottom: 16),
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () async {
                        try {
                          TodoModel result = await Get.to(TodoCreateUpdate());
                          Provider.of<TodoListProvider>(context)
                              .addTodo(result.title, result.description);
                        } on NoSuchMethodError catch (exception) {
                          print("Back button called with no input added");
                        }
                      },
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
