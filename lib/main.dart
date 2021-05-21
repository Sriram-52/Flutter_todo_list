import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/home/home.dart';
import 'package:todo/screens/authentication/sign_in.dart';
import 'package:todo/screens/authentication/sign_up.dart';
import 'package:todo/screens/wrapper.dart';
import 'package:todo/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
              home: Wrapper(),
            )
  
    );
  }
}
