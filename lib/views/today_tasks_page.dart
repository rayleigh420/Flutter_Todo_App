import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/listTask.dart';
import 'package:todo_app/widgets/task_card.dart';

class TodayTaskPage extends StatefulWidget {
  const TodayTaskPage({Key? key}) : super(key: key);

  @override
  State<TodayTaskPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<TodayTaskPage> {
  bool isLoading = false;

  @override
  void initState() {}

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
              child: tasksProvider.filterTasksByToday().isNotEmpty
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
                        ...tasksProvider
                            .filterTasksByToday()
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
