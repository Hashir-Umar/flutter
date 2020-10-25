

import 'package:flutter/material.dart';
import 'package:todo_app/shared_pref/SharedPrefHelper.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode mode;

  ThemeProvider() {
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