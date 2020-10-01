import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/TodoListProvider.dart';
import 'package:todo_app/ui/TodoListCompleted.dart';
import 'package:todo_app/ui/TodoListNew.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (BuildContext context) => TodoListProvider(),
        child: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {

  TabController _controller;
  int _fabIndex;

  @override
  void initState() {
    this._fabIndex = 0;
    this._controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        this._fabIndex = _controller.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          bottom: TabBar(
            onTap: (index){
              setState(() {
                _fabIndex = index;
              });
              print(_fabIndex.toString());
            },
            controller: _controller,
            tabs: [
              Tab(
                icon: Icon(Icons.assignment_late),
                text: "New",
              ),
              Tab(
                icon: Icon(Icons.assignment_turned_in),
                text: "Completed",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            TodoListNew(),
            TodoListCompleted(),
          ],
        ),
        floatingActionButton: Visibility (
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Provider.of<TodoListProvider>(context).addTodo("My todo 1",
                  "This my testing todo. As I am trying to add a new");
            },
          ),
          visible: this._fabIndex == 0,
        ),
      ),
    );
  }
}


