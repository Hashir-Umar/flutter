import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPlaceholder extends StatelessWidget {

  final IconData icon;
  final String text;

  MyPlaceholder({@required this.icon, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
          iconSize: 50.0,
          color: Colors.grey,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
      ],
    ));
  }
}
