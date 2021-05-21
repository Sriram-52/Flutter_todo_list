import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/services/db.dart';

class UpdateTodo extends StatefulWidget {
  final TODO reqTodo;
  final String uid;

  UpdateTodo({this.reqTodo, this.uid});

  @override
  _UpdateTodoState createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  String name;

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.reqTodo.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Firestore _firestore = Firestore(uid: widget.uid);
    return Container(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "Name"),
            onChanged: (val) => setState(() => name = val),
            initialValue: name,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _firestore.updateTodo(name, widget.reqTodo.id);
              },
              child: Text("Update"))
        ],
      ),
    );
  }
}
