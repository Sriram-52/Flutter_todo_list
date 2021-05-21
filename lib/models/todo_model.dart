import 'package:cloud_firestore/cloud_firestore.dart';

class TODO {
  final String name;
  final Timestamp createdAt;
  final bool markAsDone;
  final String id;

  TODO({this.name, this.createdAt, this.markAsDone, this.id});
}
