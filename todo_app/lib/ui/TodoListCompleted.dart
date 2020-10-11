import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/provider/TodoListProvider.dart';

class TodoListCompleted extends StatelessWidget {
  Future<List<TodoModel>> _getTodoList() async {
    var provider = TodoListProvider();
    var list = await provider.getTodoListCompleted();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getTodoList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return Container(
                child: Center(
                  child: Text(
                    "Loading...",
                  ),
                ),
              );
            else
              return snapshot.data.length == 0
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.trending_down),
                          onPressed: () {},
                          iconSize: 50.0,
                          color: Colors.grey,
                        ),
                        Text(
                          "Nothing here",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "${snapshot.data[index].title}",
                          ),
                          subtitle: Text(
                            "${snapshot.data[index].description}",
                          ),
                          focusColor: Colors.deepPurple,
                          leading: IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            onPressed: () {},
                          ),
                        );
                      },
                    );
          },
        ),
      ),
    );
  }
}
