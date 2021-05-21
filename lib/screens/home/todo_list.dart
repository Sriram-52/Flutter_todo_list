import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/screens/home/todo.dart';

class TodoList extends StatefulWidget {
  final List<TODO> todos;
  TodoList({this.todos});
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: widget.todos.length,
          itemBuilder: (context, index) {
            return Todo(todo: widget.todos[index],);
          },
        ),
      )
    );
  }
}
