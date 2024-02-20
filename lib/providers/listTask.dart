import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class ListTask with ChangeNotifier {
  final List<Task> _listTask = [
    Task(id: 1, name: "Task 1", status: false, dueTime: DateTime.now()),
    Task(
        id: 2,
        name: "Task 2",
        status: true,
        dueTime: DateTime.now().add(const Duration(days: 1))),
    Task(
        id: 3,
        name: "Task 3",
        status: true,
        dueTime: DateTime.now().subtract(const Duration(days: 1))),
    Task(id: 4, name: "Task 4", status: false, dueTime: DateTime.now()),
  ];

  List<Task> get tasks => _listTask;

  void updateTaskStatus(int? taskId) {
    final index = _listTask.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _listTask[index].status = !_listTask[index].status;
      notifyListeners();
    }
  }

  List<Task> filterTasksByToday() {
    final now = DateTime.now();
    return _listTask
        .where((task) =>
            task.dueTime?.year == now.year &&
            task.dueTime?.month == now.month &&
            task.dueTime?.day == now.day)
        .toList();
  }

  List<Task> filterTasksComingSoon() {
    final now = DateTime.now();
    final upcomingTasks =
        _listTask.where((task) => task.dueTime!.isAfter(now)).toList();
    // Sắp xếp các task theo thời gian sắp đến
    upcomingTasks.sort((a, b) => a.dueTime!.compareTo(b.dueTime!));
    return upcomingTasks;
  }
}
