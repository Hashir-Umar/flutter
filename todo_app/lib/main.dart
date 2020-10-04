import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:todo_app/ui/TodoListCompleted.dart';
import 'package:todo_app/ui/TodoListNew.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => TodoListProvider(),
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
      ),
    );
  }
}


