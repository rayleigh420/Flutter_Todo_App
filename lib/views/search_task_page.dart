import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:todo_app/providers/listTask.dart';

class SearchTaskPage extends StatefulWidget {
  @override
  _SearchTaskPageState createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  late TextEditingController _searchController;
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _debounce = Timer(Duration(milliseconds: 500), () {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void _onSearchTextChanged(String keyword, ListTask taskProvider) {
    _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      taskProvider.searchTasksByName(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<ListTask>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchTextChanged('', taskProvider);
                  },
                ),
              ),
              onChanged: (value) => _onSearchTextChanged(value, taskProvider),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.filteredTasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text('Due Date: ${task.dueTime.toString()}'),
                    // Định nghĩa hành động khi nhấn vào task
                    onTap: () {
                      // Thực hiện hành động tương ứng khi nhấn vào task
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
