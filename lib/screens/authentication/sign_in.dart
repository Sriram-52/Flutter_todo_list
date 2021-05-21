import 'package:flutter/material.dart';
import 'package:todo/constants/loading.dart';
import 'package:todo/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;

  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toogleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"))
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    try {
                      dynamic res = _authService.signInWithEmailAndPassword(
                          email, password);
                      print(res);
                    } catch (e) {
                      setState(() {
                        loading = false;
                        error = e.toString();
                      });
                    }
                  },
                  child: Text("Sign in")),
              SizedBox(
                height: 10,
              ),
              Text(error)
            ],
          ),
        ),
      ),
    );
  }
}
