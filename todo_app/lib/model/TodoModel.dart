class TodoModel {
  int _id;
  String _title;
  String _description;
  String _date;
  String _time;
  int _isDone;

  TodoModel(this._id, this._title, this._description, this._date, this._time,
      this._isDone);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'title': _title,
      'description': _description,
      'date': _date,
      'time': _time,
      'isDone': _isDone,
    };

    return map;
  }

  TodoModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _date = map['date'];
    _time = map['time'];
    _isDone = map['isDone'];
  }

  int get id => this._id;
  String get title => this._title;
  String get description => this._description;
  String get date => this._date;
  String get time => this._time;
  int get isDone => this._isDone;

  set id(int id) => this._id = id;
  set isDone(int isDone) => this._isDone = isDone;
}
