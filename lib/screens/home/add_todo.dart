import 'package:flutter/material.dart';
import 'package:todo/services/db.dart';

class AddTodo extends StatefulWidget {
  final String uid;

  AddTodo({this.uid});
  
  
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String name;

  @override
  Widget build(BuildContext context) {
    final Firestore _firestore = Firestore(uid: widget.uid);
    return Container(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "Name"),
            onChanged: (val) => setState(() => name = val),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _firestore.addTodo(name);
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
