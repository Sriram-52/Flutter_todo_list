import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/home/update_todo.dart';
import 'package:todo/services/db.dart';

class Todo extends StatelessWidget {
  final TODO todo;
  Todo({this.todo});
  @override
  Widget build(BuildContext context) {
    final CustomUser user = Provider.of<CustomUser>(context);
    final Firestore _firestore = Firestore(uid: user.uid);

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: UpdateTodo(
                uid: user.uid,
                reqTodo: todo,
              ),
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Row(
            children: [
              Text(
                todo.name,
                style: TextStyle(
                    decoration: !todo.markAsDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              IconButton(
                icon: Icon(todo.markAsDone ? Icons.update : null),
                onPressed: () => todo.markAsDone ? _showSettingsPanel() : null,
              ),
              IconButton(
                  icon: Icon(todo.markAsDone ? Icons.delete : Icons.mark_as_unread ),
                  onPressed: () {
                    _firestore.markAs(todo.id, todo.markAsDone ? false : true);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
