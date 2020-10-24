import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/provider/TodoListProvider.dart';
import 'package:todo_app/util/DateTimeUtil.dart';
import 'package:intl/intl.dart';

class TodoCreateUpdate extends StatefulWidget {
  @override
  _TodoCreateUpdateState createState() => _TodoCreateUpdateState();
}

class _TodoCreateUpdateState extends State<TodoCreateUpdate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _id;
  String _title;
  String _description;
  String _date;
  String _time;
  int _isDone;
  String _pageName = "Add Todo";

  String timeText;
  String dateText;

  @override
  void initState() {
    timeText = "Time";
    dateText = "Date";
    _id = null;
    _title = "";
    _description = "";
    _date = null;
    _time = null;
    _isDone = 0;

    if (Get.arguments != null) {
      final TodoModel mArgument = Get.arguments;
      _id = mArgument.id;
      _title = mArgument.title;
      _description = mArgument.description;
      _date = mArgument.date;
      _time = mArgument.time;
      _isDone = mArgument.isDone;
      _pageName = "Update Todo";
      dateText = _date;
      timeText = _time;
      print(mArgument.toMap().toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Enter title",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                    maxLines: null,
                    initialValue: _description,
                    onSaved: (input) => _description = input,
                    validator: (input) =>
                        input.isEmpty ? "Please type description" : null,
                    keyboardType: TextInputType.multiline,
                    minLines: 6,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Enter description",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    MyClip(
                      label: dateText,
                      icon: Icons.date_range,
                      onPress: () async {
                        int currentYear = int.tryParse(
                            DateFormat('y').format(DateTime.now()));
                        var picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(currentYear),
                          lastDate: DateTime(2025),
                        );

                        if (picked != null) {
                          setState(() {
                            dateText = DateFormat('y-M-d').format(picked);
                            _date = DateFormat('y-M-d').format(picked);
                          });
                          print(_date);
                        }
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    MyClip(
                      label: timeText,
                      icon: Icons.access_time,
                      onPress: () async {
                        var picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget child) {
                            return Container(
                                child: child
                            );
                          },
                        );

                        if (picked != null) {
                          setState(() {
                            timeText = DateTimeUtil.formatTimeOfDay(picked,
                                formatter: "jm");
                            _time = DateTimeUtil.formatTimeOfDay(picked);
                          });
                        }
                      },
                    ),
                  ],
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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

      print(_date);
      if (_date == null) {
        Get.snackbar("Empty date", "Please select a date to continue",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (_time == null) {
        Get.snackbar("Empty time", "Please select a time to continue",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (Get.arguments == null)
        Provider.of<TodoListProvider>(context)
            .addTodo(_title, _description, _date, _time);
      else
        Provider.of<TodoListProvider>(context)
            .updateTodo(_id, _title, _description, _date, _time, 0);

      Get.back();
    }
  }
}

class MyClip extends StatelessWidget {
  String _label;
  IconData _icon;
  Function _onPress;

  MyClip({label, icon, onPress}) {
    this._label = label;
    this._icon = icon;
    this._onPress = onPress;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: this._onPress,
        child: Chip(
          elevation: 2,
          backgroundColor: Colors.blue,
          label: Padding(
            padding: EdgeInsets.all(5),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      this._icon,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    text: "  " + this._label,
                  ),
                ],
              ),
            ),
          ),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
