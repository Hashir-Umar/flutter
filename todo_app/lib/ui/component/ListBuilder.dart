import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/TodoCreateUpdate.dart';
import 'package:todo_app/util/AlertUtil.dart';
import 'package:todo_app/util/DateTimeUtil.dart';

class MyList extends StatelessWidget {
  final List<TodoModel> list;
  final String tileType;

  MyList({@required this.list, @required this.tileType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(elevation: 1, child: getWidget(list, tileType, index));
      },
    );
  }

  getWidget(List<TodoModel> list, String type, int index) {
    if (type == "New") return MyNewListTile(item: list[index]);
    return MyCompletedListTile(item: list[index]);
  }
}

class MyNewListTile extends StatelessWidget {
  final TodoModel item;

  MyNewListTile({@required this.item});

  final List<String> popupMenuItemTitle = ["Finished", "Delete"];

  List<PopupMenuItem> _buildPopupMenuItem() {
    return List<PopupMenuItem>.generate(
      popupMenuItemTitle.length,
      (int index) => PopupMenuItem(
        child: Text(popupMenuItemTitle[index]),
        value: popupMenuItemTitle[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(TodoCreateUpdate(),
            transition: Transition.zoom, arguments: item);
      },
      title: Text(
        item.title,
      ),
      subtitle: Text(
        DateTimeUtil.getFormattedDateTimeStr(
            dateTime: item.date + " " + item.time,
            formatter: "MMMM, dd hh:mm aa"),
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
          if (selectedDropDownItem == popupMenuItemTitle[0])
            Provider.of<TodoListProvider>(context).complete(item.id)
          else
            confirmDelete(context)
        },
        itemBuilder: (BuildContext context) => _buildPopupMenuItem(),
        tooltip: "Actions",
      ),
    );
  }

  confirmDelete(context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertUtil.simpleAlertDialog(
              title: "Delete ?",
              description: "Are you sure you want to remove this todo?",
              positiveText: "Yes",
              onPositiveClick: () {
                Navigator.of(context).pop();
                Provider.of<TodoListProvider>(context).remove(item.id);
              },
              negativeText: "No",
              onNegativeClick: () {
                Navigator.of(context).pop();
              });
        });
  }
}

class MyCompletedListTile extends StatelessWidget {
  final TodoModel item;

  MyCompletedListTile({@required this.item});

  final List<String> popupMenuItemTitle = ["Delete"];

  List<PopupMenuItem> _buildPopupMenuItem() {
    return List<PopupMenuItem>.generate(
      popupMenuItemTitle.length,
      (int index) => PopupMenuItem(
        child: Text(popupMenuItemTitle[index]),
        value: popupMenuItemTitle[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
      ),
      subtitle: Text(
        DateTimeUtil.getFormattedDateTimeStr(
            dateTime: item.date + " " + item.time,
            formatter: "MMMM, dd hh:mm aa"),
        maxLines: 2,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.check_circle_sharp,
          color: Colors.green,
          size: 30.0,
        ),
        onPressed: () {},
      ),
      trailing: PopupMenuButton(
        onSelected: (selectedDropDownItem) => {
          if (selectedDropDownItem == popupMenuItemTitle[0])
            confirmDelete(context)
        },
        itemBuilder: (BuildContext context) => _buildPopupMenuItem(),
        tooltip: "Actions",
      ),
    );
  }

  confirmDelete(context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertUtil.simpleAlertDialog(
              title: "Delete ?",
              description: "Are you sure you want to remove this todo?",
              positiveText: "Yes",
              onPositiveClick: () {
                Navigator.of(context).pop();
                Provider.of<TodoListProvider>(context).remove(item.id);
              },
              negativeText: "No",
              onNegativeClick: () {
                Navigator.of(context).pop();
              });
        });
  }
}
