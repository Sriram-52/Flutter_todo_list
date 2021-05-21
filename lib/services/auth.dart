import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/user_model.dart';

class AuthService {
  final String uid;
  AuthService({this.uid});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser _customUser(User user) {
    return user != null ? CustomUser(uid: user.uid, email: user.email) : null;
  }

  Stream<CustomUser> get user {
    Stream<User> res = _auth.authStateChanges();
    return res.map(_customUser);
  }

  Future<CustomUser> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _customUser(user);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<CustomUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _customUser(user);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
