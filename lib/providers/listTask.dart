import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class ListTask with ChangeNotifier {
  final List<Task> _listTask = [
    Task(id: 1, name: "Task 1", status: false),
    Task(id: 2, name: "Task 2", status: true),
    Task(id: 3, name: "Task 3", status: true),
    Task(id: 4, name: "Task 4", status: false),
  ];

  List<Task> get tasks => _listTask;

  void updateTaskStatus(int? taskId) {
    final index = _listTask.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _listTask[index].status = !_listTask[index].status;
      notifyListeners();
    }
  }
}
