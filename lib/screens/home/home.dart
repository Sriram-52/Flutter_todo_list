import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/loading.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/screens/home/add_todo.dart';
import 'package:todo/screens/home/todo_list.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/services/db.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  Stream todos;

  @override
  void initState() {
    todos = FirebaseFirestore.instance
        .collection("TODOS")
        .where('uid', isEqualTo: widget.uid)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Firestore _firestore = Firestore(uid: widget.uid);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: AddTodo(uid: widget.uid,),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
          actions: [
            FlatButton.icon(
                onPressed: () {
                  try {
                    _authService.signOut();
                  } catch (e) {
                    print("Failed to signout");
                  }
                },
                icon: Icon(Icons.person),
                label: Text("Sign Out")),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.add),
                label: Text("Add Todo"))
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: todos,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Text('No Todos'));
                case ConnectionState.waiting:
                  return Loading();
                case ConnectionState.active:
                case ConnectionState.done:
                  List<TODO> data = _firestore.getTodos(snapshot);
                  return TodoList(
                    todos: data,
                  );
                default:
                  return null;
              }
            }));
  }
}
