import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/TodoCreateUpdate.dart';
import 'package:intl/intl.dart';

class TodoListToday extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    return Container(
      child: Consumer<TodoListProvider>(
        builder: (context, todo, child) {
          return Stack(
            children: [
              todo.todoListToday.length == 0
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
                itemCount: todo.todoListToday.length,
                itemBuilder: (context, index) {
                  return false
                      ? Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      DateFormat.MMMMd().format(DateTime.now()),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.5)),
                    ),
                  )
                      : Card(
                    elevation: 1,
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        todo.todoListToday[index].title,
                      ),
                      subtitle: Text(
                        todo.todoListToday[index].description,
                        maxLines: 2,
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.timer,
                          color: Colors.green,
                          size: 30.0,
                        ),
                        onPressed: () {},
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (selectedDropDownItem) => {
                          // if (selectedDropDownItem == "Finished")
                          //   Provider.of<TodoListProvider>(context)
                          //       .complete(index)
                          // else
                          //   {
                          //     showDialog<void>(
                          //         context: context,
                          //         barrierDismissible: true,
                          //         // user must tap button!
                          //         builder: (BuildContext context) {
                          //           return AlertUtil
                          //               .simpleAlertDialog(
                          //               title: "Delete ?",
                          //               description:
                          //               "Are you sure you want to remove this todo?",
                          //               positiveText: "Yes",
                          //               onPositiveClick: () {
                          //                 Navigator.of(context)
                          //                     .pop();
                          //                 Provider.of<TodoListProvider>(
                          //                     mContext)
                          //                     .remove(todo
                          //                     .todoList[
                          //                 index]
                          //                     .id);
                          //               },
                          //               negativeText: "No",
                          //               onNegativeClick: () {
                          //                 Navigator.of(context)
                          //                     .pop();
                          //               });
                          //         })
                          //   }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Text("Finished"),
                            value: "Finished",
                          ),
                          PopupMenuItem(
                            child: Text("Delete"),
                            value: "Delete",
                          ),
                        ],
                        tooltip: "Actions",
                      ),
                    ),
                  );
                },
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
    );
  }
}
