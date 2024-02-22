import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'dart:math';
import 'dart:async';

class ListTask with ChangeNotifier {
  final List<Task> _listTask = [
    Task(id: 1, name: "Task 1", status: false, dueTime: DateTime.now()),
    Task(
        id: 2,
        name: "Task 2",
        status: false,
        dueTime: DateTime.now().add(const Duration(days: 1))),
    Task(
        id: 3,
        name: "Task 3",
        status: false,
        dueTime: DateTime.now().subtract(const Duration(days: 1))),
    Task(id: 4, name: "Task 4", status: false, dueTime: DateTime.now()),
  ];
  List<Task> _filteredTasks = [];

  Timer? _debounce;

  List<Task> get tasks => _listTask;
  List<Task> get filteredTasks => _filteredTasks;

  void addTask(String name, DateTime dueTime) {
    _listTask.add(Task(
        id: Random().nextInt(1000000),
        name: name,
        status: false,
        dueTime: dueTime));
    notifyListeners();
  }

  void updateTaskStatus(int? taskId) {
    // final index = _listTask.indexWhere((task) => task.id == taskId);
    // if (index != -1) {
    //   _listTask[index].status = !_listTask[index].status;
    //   notifyListeners();
    // }
    _listTask.removeWhere((task) => task.id == taskId);
    _filteredTasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
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

  void searchTasksByName(String keyword) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _filteredTasks.clear();
      if (keyword.isEmpty) {
        // Nếu keyword rỗng, hiển thị tất cả task
        _filteredTasks.addAll(_listTask);
      } else {
        // Nếu có keyword, tìm kiếm và lọc các task phù hợp
        _filteredTasks.addAll(_listTask.where(
            (task) => task.name.toLowerCase().contains(keyword.toLowerCase())));
      }
      notifyListeners();
    });
  }
}
