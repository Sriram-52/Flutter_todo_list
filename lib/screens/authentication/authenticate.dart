import 'package:flutter/material.dart';
import 'package:todo/screens/authentication/sign_in.dart';
import 'package:todo/screens/authentication/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signIn = true;

  void toogle() {
      setState(() {
        signIn = !signIn;
      });
    }

  @override
  Widget build(BuildContext context) {

    if (signIn) {
      return SignIn(toogleView: toogle,);
    }
    return SignUp(toogle: toogle);
  }
}
