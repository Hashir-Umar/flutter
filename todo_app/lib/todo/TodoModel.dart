class TodoModel {

  String _title;
  String _description;
  int _isDone;

  TodoModel(this._title, this._description, this._isDone);

  String get title => this._title;
  String get description => this._description;
  int get isDone => this._isDone;

  set isDone(int isDone) => this._isDone = isDone;
}