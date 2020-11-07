import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/TodoCreateUpdate.dart';
import 'package:todo_app/util/DateTimeUtil.dart';
import 'component/ListBuilder.dart';
import 'component/MyPlaceholder.dart';

class TodoListToday extends StatelessWidget {

  @override
  Widget build(BuildContext mContext) {

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateTimeUtil.getCurrentDateFormatted(formatter: 'MMMM, d')),
            Text(
              DateTimeUtil.getCurrentDateFormatted(formatter: 'EEEE'),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Consumer<TodoListProvider>(
          builder: (context, todo, child) {
            return Stack(
              children: [
                todo.todoListToday.length == 0
                    ? MyPlaceholder(
                        icon: Icons.trending_down,
                        text: "Nothing to do",
                      )
                    : MyList(
                        list: todo.todoListToday,
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
