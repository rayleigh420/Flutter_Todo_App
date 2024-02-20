import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/listTask.dart';
import 'package:todo_app/widgets/task_card.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  // var tasks = ["task 1", "task 2", "task 3"];
  late List<Task> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    tasks.add(Task(id: 1, name: "Task 1", status: true));
    // super.initState();
    // tasks.add("Task 1");
    // tasks.add("Task 1");
    // tasks.add("Task 1");
    // tasks.add("Task 1");
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          )
        : Consumer<ListTask>(builder: (context, tasksProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: tasksProvider.tasks.isNotEmpty
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                // _fetchAllTasks();
                              });
                            },
                            child: const Text('Refresh'),
                          ),
                        ),
                        ...tasksProvider.tasks
                            .map((task) => TaskCard(
                                  task: task,
                                  updateTask: tasksProvider.updateTaskStatus,
                                ))
                            .toList()
                      ],
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                // _fetchAllTasks();
                              });
                            },
                            child: const Text('Refresh'),
                          ),
                        ),
                        const Text('You have no unfinished todo')
                      ],
                    ),
            );
          });
  }

  void _updateTask(int? id) {
    setState(() {
      final index = tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        tasks[index].status = !tasks[index].status;
      }
    });
  }
}
