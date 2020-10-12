import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:todo_app/ui/component/MyPlaceholder.dart';

import 'component/ListBuilder.dart';

class TodoListCompleted extends StatelessWidget {
  Future<List<TodoModel>> _getTodoList() async {
    var provider = TodoListProvider();
    var list = await provider.getTodoListCompleted();
    print("My list: " + list.toString());
    return list;
  }

  @override
  Widget build(BuildContext mContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Task"),
      ),
      body: Container(
        child: Consumer<TodoListProvider>(
          builder: (context, todo, child) {
            return todo.todoListCompleted.length == 0
                ? MyPlaceholder(
                    icon: Icons.trending_down,
                    text: "Nothing to do",
                  )
                : MyList(
                    list: todo.todoListCompleted,
                    tileType: "Complete",
                  );
          },
        ),
      ),
    );
  }
}
