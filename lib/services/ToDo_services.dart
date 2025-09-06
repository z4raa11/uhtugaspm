import 'package:flutter/foundation.dart';
import '../models/ToDo.dart';

class ToDoServices extends ChangeNotifier {
  final List<ToDo> _todos = [];
  final List<ToDo> _history = [];

  List<ToDo> get todos => _todos;
  List<ToDo> get history => _history;

  // Tambah todo
  void addToDo(String title, String desc) {
    if (title.trim().isEmpty) return;
    _todos.insert(0, ToDo(title: title.trim(), description: desc.trim()));
    notifyListeners();
  }

  // Toggle pada halaman utama (centang untuk dipindah nanti)
  void toggle(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  // Hapus yang dicentang (pindahkan ke history)
  void deleteSelected() {
    final selected = _todos.where((t) => t.isDone).toList();
    for (var t in selected) {
      _todos.remove(t);
      t.isDone = false;
      _history.insert(0, t);
    }
    notifyListeners();
  }

  // Toggle di history (centang sebelum hapus permanen)
  void toggleHistory(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  // Hapus permanen yang dicentang di history
  void deleteHistorySelected() {
    _history.removeWhere((t) => t.isDone);
    notifyListeners();
  }
}



