import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/authentication/authenticate.dart';
import 'package:todo/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final CustomUser user = Provider.of<CustomUser>(context);
    if (user == null) {
      return Authenticate();
    }
    return Home(uid: user.uid,);
  }
}
