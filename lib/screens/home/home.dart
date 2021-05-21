import 'package:flutter/material.dart';
import 'package:todo/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
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
              label: Text("Sign Out"))
        ],
      ),
      body: Text("home screen"),
    );
  }
}
