import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class Firestore {
  final String uid;
  Firestore({this.uid});

  final db = FirebaseFirestore.instance;
  final todoRef = FirebaseFirestore.instance.collection("TODOS");

  TODO _snapShotToTODO(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    String name = data["name"] ?? "";
    Timestamp createdAt = data["createdAt"] ?? Timestamp.now();
    bool markAsDone = data["isExist"] ?? false;
    String id = data["id"] ?? "";
    return TODO(name: name, createdAt: createdAt, markAsDone: markAsDone, id: id);
  }

  List<TODO> getTodos(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return snapshot.data.docs.map(_snapShotToTODO).toList();
  }

  Future addTodo(String name) {
    final newTodo = todoRef.doc();
    return newTodo.set({
      "name": name,
      "isExist": true,
      "id": newTodo.id,
      "createdAt": Timestamp.now(),
      "uid": this.uid,
    }).catchError((e) => throw e);
  }

  Future updateTodo(String name, String id) {
    final updateTodo = todoRef.doc(id);
    return updateTodo.update({
      "name": name,
    }).catchError((e) => throw e);
  }

  Future markAs(String id, bool val) {
    final docRef = todoRef.doc(id);
    return docRef.update({
      "isExist": val
    }).catchError((e) => throw e);
  }
}
