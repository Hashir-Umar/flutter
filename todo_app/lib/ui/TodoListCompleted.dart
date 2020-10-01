import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/TodoListProvider.dart';

class TodoListCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    return Container(
      child: Consumer<TodoListProvider>(
        builder: (context, todo, child) {
          return todo.todoListCompleted.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.check_box),
                      onPressed: () {},
                      iconSize: 50.0,
                      color: Colors.grey,
                    ),
                    Text(
                      "No finished task",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ))
              : ListView.builder(
                  itemCount: todo.todoListCompleted.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${todo.todoListCompleted[index].title}",
                      ),
                      subtitle: Text(
                        "${todo.todoListCompleted[index].title}",
                      ),
                      focusColor: Colors.deepPurple,
                      leading: IconButton(
                        icon: Icon(
                          Icons.check_box,
                          color: Colors.blueAccent,
                          size: 30.0,
                        ),
                        onPressed: () {},
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
