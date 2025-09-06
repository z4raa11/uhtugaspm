import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ToDo.dart';
import '../services/ToDo_services.dart';

const kBlue = Color(0xFF577C8E);
const kCream = Color(0xFFF2E7DD);

// Reusable ToDo item widget for both pages.
// Behavior depends on whether item is in main list (on toggle -> service.toggle)
// or in history list (on toggle -> service.toggleHistory).
class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final bool isHistory; // false = main list, true = history

  const ToDoItem({super.key, required this.todo, this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ToDoServices>(context, listen: false);

    return Card(
      color: kCream,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) {
            if (isHistory) {
              service.toggleHistory(todo);
            } else {
              service.toggle(todo);
            }
          },
          activeColor: kBlue,
          checkColor: kCream,
          side: const BorderSide(color: kBlue),
        ),
        title: Text(
          todo.title,
          style: const TextStyle(color: kBlue, fontWeight: FontWeight.w600),
        ),
        subtitle: todo.description.isEmpty
            ? null
            : Text(todo.description, style: const TextStyle(color: kBlue)),
      ),
    );
  }
}
