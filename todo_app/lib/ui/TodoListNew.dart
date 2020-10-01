import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/TodoListProvider.dart';

class TodoListNew extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    return Container(
      child: Consumer<TodoListProvider>(
        builder: (context, todo, child) {
          return todo.todoList.length == 0
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
                    )
                  ],
                ))
              : ListView.builder(
                  itemCount: todo.todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${todo.todoList[index].title}",
                      ),
                      subtitle: Text(
                        "${todo.todoList[index].title}",
                      ),
                      onLongPress: () async {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
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
                                      Provider.of<TodoListProvider>(mContext)
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
                );
        },
      ),
    );
  }
}
