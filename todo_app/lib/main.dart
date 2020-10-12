import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/ui/TodoListToday.dart';
import 'package:todo_app/ui/component/MainDrawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoListProvider(),
      child: GetMaterialApp(
        title: 'Todo application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("My Day"),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Colors.white,
            height: 20,
            width: 20,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: [
          TodoListToday(),
        ],
      ),
    );
  }
}
