import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/TodoCreateUpdate.dart';

import 'component/ListBuilder.dart';
import 'component/MyPlaceholder.dart';

class TodoListNew extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
      ),
      body: Container(
        child: Consumer<TodoListProvider>(
          builder: (context, todo, child) {
            return Stack(
              children: [
                todo.todoList.length == 0
                    ? MyPlaceholder(
                        icon: Icons.trending_down,
                        text: "Nothing to do",
                      )
                    : MyList(
                        list: todo.todoList,
                        tileType: "New",
                      ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 16, bottom: 16),
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          Get.to(
                            TodoCreateUpdate(),
                            transition: Transition.leftToRight,
                          );
                        },
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
