import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/TodoListProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (BuildContext context) => TodoListProvider(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
        child: Consumer<TodoListProvider>(
          builder: (context, todo, child) {
            return ListView.builder(
              itemCount: todo.todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${todo.todoList[index].title}",
                                  style: TextStyle(fontSize: 18.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${todo.todoList[index].description}",
                                  style: TextStyle(fontSize: 14.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(todo.todoList[index].isDone == 1 ? Icons.assignment_turned_in : Icons.assignment_late),
                            color: todo.todoList[index].isDone == 1 ? Colors.green : Colors.red,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<TodoListProvider>(context).addTodo(
              "My todo 1", "This my testing todo. As I am trying to add a new");
        },
      ),
    );
  }
}
