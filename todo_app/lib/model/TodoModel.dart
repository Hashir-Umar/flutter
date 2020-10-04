import 'package:uuid/uuid.dart';

class TodoModel {

  int _id;
  String _title;
  String _description;
  int _isDone;

  TodoModel(this._id, this._title, this._description, this._isDone);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': _id,
      'title': _title,
      'description': _description,
      'isDone': _isDone,
    };

    return map;
  }

  TodoModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _isDone = map['isDone'];
  }

  int get id => this._id;
  String get title => this._title;
  String get description => this._description;
  int get isDone => this._isDone;

  set id(int id) => this._id = id;
  set isDone(int isDone) => this._isDone = isDone;
}