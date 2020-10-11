import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/TodoListCompleted.dart';
import 'package:todo_app/ui/TodoListNew.dart';

import '../TodoCreateUpdate.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final int _listCount = 3;
  bool _darkMode = false;

  @override
  void initState() {
    this._darkMode = false;
    super.initState();
  }

  final _listItemsTitle = ["Tasks", "Completed", "Dark Mode"];
  final _listItemsIcons = [
    "assets/icons/todo.svg",
    "assets/icons/completed_task.svg",
    ""
  ];

  final _callBacks = <Function>[
    () {
      Get.to(TodoListNew());
    },
    () {
      Get.to(TodoListCompleted());
    },
    null
  ];

  Widget getListItem(int index) {
    if (index == 2) {
      return SwitchListTile(
        title: Text(
          _listItemsTitle[index],
          style: TextStyle(
            letterSpacing: 1.1,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
        value: _darkMode,
        onChanged: (value) {
          setState(() {
            this._darkMode = value;
          });
        },
      );
    }

    return ListTile(
      title: Text(
        _listItemsTitle[index],
        style: TextStyle(
          letterSpacing: 1.1,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
      trailing: IconButton(
        icon: SvgPicture.asset(
          _listItemsIcons[index],
          width: 20,
          height: 20,
        ),
        onPressed: null,
      ),
      onTap: _callBacks[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Drawer(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/drawer_header.jpg"),
                                fit: BoxFit.fill)),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 68,
                                    backgroundImage: AssetImage("assets/images/male_image.jpg"),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Welcome,\n",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Hashir Umar",
                                          style: TextStyle(
                                            letterSpacing: 1.1,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.separated(
                      itemCount: _listCount,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 1),
                      itemBuilder: (BuildContext context, int index) {
                        return getListItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, right: 10),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "VERSION 1.0",
                    style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.grey.shade500,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
