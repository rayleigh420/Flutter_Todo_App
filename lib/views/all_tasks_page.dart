import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/listTask.dart';
import 'package:todo_app/widgets/task_card.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  bool isLoading = false;

  @override
  void initState() {
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
}
