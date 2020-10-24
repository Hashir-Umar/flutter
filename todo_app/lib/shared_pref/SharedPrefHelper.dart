import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {

  static const THEME_STATUS = "THEMESTATUS";

  setTheme(bool value) async {
    print("setTheme");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    print("getTheme");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}