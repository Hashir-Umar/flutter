class UserModel {
  int _id;
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _imagePath;

  UserModel(this._id, this._firstName, this._lastName, this._email, this._password, this._imagePath);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
      'password': _password,
      'imagePath': _imagePath,
    };

    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _firstName = map['firstName'];
    _lastName = map['lastName'];
    _email = map['email'];
    _password = map['password'];
    _imagePath = map['imagePath'];
  }

  int get id => this._id;
  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get email => this._email;
  String get password => this._password;
  String get imagePath => this._imagePath;
  String get fullName => this._firstName + " " + this._lastName;

  set id(int id) => this._id = id;
  set imagePath(String imagePath) => this._imagePath = imagePath;
}
