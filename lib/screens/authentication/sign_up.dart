import 'package:flutter/material.dart';
import 'package:todo/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toogle;

  SignUp({this.toogle});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        actions: [
          ElevatedButton(
              onPressed: () {
                widget.toogle();
              },
              child: Text("Sign in"))
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
                      dynamic res = _authService.createUserWithEmailAndPassword(
                          email, password);
                    } catch (e) {
                      setState(() {
                        loading = false;
                        error = e.toString();
                      });
                    }
                  },
                  child: Text("Register")),
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
