import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/TodoModel.dart';

class TodoCreateUpdate extends StatefulWidget {
  @override
  _TodoCreateUpdateState createState() => _TodoCreateUpdateState();
}

class _TodoCreateUpdateState extends State<TodoCreateUpdate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _id;
  String _title;
  String _description;
  int _isDone;
  String _pageName = "Add Todo";

  @override
  Widget build(BuildContext context) {
    _id = null;
    _title = "";
    _description = "";
    _isDone = 0;

    if (Get.arguments != null) {
      final TodoModel mArgument = Get.arguments;
      _id = mArgument.id;
      _title = mArgument.title;
      _description = mArgument.description;
      _isDone = mArgument.isDone;
      _pageName = "Update Todo";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_pageName),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextFormField(
                    initialValue: _title,
                    onSaved: (input) => _title = input,
                    validator: (input) =>
                        input.isEmpty ? "Please type title" : null,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Enter title",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    initialValue: _description,
                    onSaved: (input) => _description = input,
                    validator: (input) =>
                        input.isEmpty ? "Please type description" : null,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Enter description",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.09,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: GestureDetector(
                      onTap: _submit,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Get.back(result: TodoModel(_id, _title, _description, _isDone));
    }
  }
}
