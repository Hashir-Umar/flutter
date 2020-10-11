import 'package:flutter/material.dart';

class AlertUtil {
  static AlertDialog simpleAlertDialog(
      {String title,
      String description,
      String positiveText,
      Function onPositiveClick,
      String negativeText,
      Function onNegativeClick}) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        FlatButton(
          child: Text(positiveText),
          textColor: Colors.green,
          onPressed: onPositiveClick,
        ),
        FlatButton(
          child: Text(negativeText),
          textColor: Colors.red,
          onPressed: onNegativeClick,
        ),
      ],
    );
  }
}
