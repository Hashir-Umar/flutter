import 'package:uuid/uuid.dart';

class TodoModel {

  String _id;
  String _title;
  String _description;
  int _isDone;

  TodoModel(this._title, this._description, this._isDone) {
    var uuid = Uuid();
    this._id = uuid.v1();
  }

  String get id => this._id;
  String get title => this._title;
  String get description => this._description;
  int get isDone => this._isDone;

  set isDone(int isDone) => this._isDone = isDone;
}