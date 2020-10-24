import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/shared_pref/SharedPrefHelper.dart';
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
      create: (_) => ThemeModel(),
      child: ChangeNotifierProvider(
          create: (_) => TodoListProvider(),
          child: Consumer<ThemeModel>(
            builder: (BuildContext context, value, Widget child) {
              return GetMaterialApp(
                title: 'Todo application',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.blue,
                  /* light theme settings */
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  /* dark theme settings */
                ),
                themeMode: value.mode,
                debugShowCheckedModeBanner: false,
                home: MyHome(),
              );
            },
          )),
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
      resizeToAvoidBottomPadding: false,
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

class ThemeModel with ChangeNotifier {
  ThemeMode mode;

  ThemeModel() {
    getTheme();
  }

  Future<bool> getThemeMode() async {
    var sf = SharedPrefHelper();
    bool variable = await sf.getTheme();
    print("variable: " + variable.toString());
    return variable;
  }

  changeMode(variable) async {
    var sf = SharedPrefHelper();
    await sf.setTheme(variable);
    mode = variable ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> getTheme() async {
    var sf = SharedPrefHelper();
    bool variable = await sf.getTheme();
    mode = variable ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
