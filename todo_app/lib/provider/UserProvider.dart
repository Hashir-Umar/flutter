import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/model/UserModel.dart';
import 'package:todo_app/sql/DBHelper.dart';
import 'package:todo_app/util/Constant.dart';
import 'package:todo_app/util/DateTimeUtil.dart';

class UserProvider extends ChangeNotifier {
  DBHelper _dbHelper;
  UserModel _user;
  List<UserModel> _users = [];

  UserModel get user => this._user;

  List<UserModel> get users => this._users;

  static const USER_TABLE = "User";

  UserProvider() {
    print("I am here User");
    _dbHelper = DBHelper();
    getUserByEmail(email);
  }

  void dispose() async {
    super.dispose();
    _dbHelper.close();
  }

  Future<List<UserModel>> getUser() async {
    try {
      if (_dbHelper != null) {
        List<Map> maps = await _dbHelper.fetch('SELECT * FROM $USER_TABLE');

        List<UserModel> list = [];
        for (int i = 0; i < maps.length; i++) {
          list.add(UserModel.fromMap(maps[i]));
        }

        _users = list;
      }
    } on Exception catch (exception) {
      _users = [];
      print(exception.toString());
    }

    notifyListeners();
    return _users;
  }

  Future<UserModel> getUserByEmail(String email) async {
    await getUser();
    print(_users.length);
    int index = -1;
    UserModel user;
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].email == email) {
        index = i;
        user = _users[index];
        _user = user;
        break;
      }
    }

    print("getUserByEmail: $email");

    if (user == null) {

      UserModel guestUser = UserModel(null, firstName, lastName, email,
          password, null);

      print("guestUser: ${guestUser.toMap()}");

      _user = await _dbHelper.insert(
          USER_TABLE,
          guestUser);

      _users.add(_user);
    }

    print(_user.toMap());
    return _user;
  }

  addUser(String firstName, String lastName, String email, String password,
      String imagePath) async {
    var user = await _dbHelper.insert(USER_TABLE,
        UserModel(null, firstName, lastName, email, password, imagePath));

    _users.add(user);

    notifyListeners();
  }

  updateUser(int id, String firstName, String lastName, String email,
      String password, String imagePath) async {
    var user = await _dbHelper.update(USER_TABLE,
        UserModel(id, firstName, lastName, email, password, imagePath));

    _users.removeWhere((element) => element.id == id);
    _users.add(user);

    notifyListeners();
  }

  updateUserImage(String email, String imagePath) async {
    print(_users.length);
    var index = -1;
    for (int i = 0; i < _users.length; i++) {
      print(_users[i].toMap());
      if (_users[i].email == email) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      print("updated $email, $imagePath");
      _users[index].imagePath = imagePath;
      await _dbHelper.update(USER_TABLE, _users[index]);
      notifyListeners();
    }
  }
}
