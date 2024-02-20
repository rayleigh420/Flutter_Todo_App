import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/providers/listTask.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController _taskNameController;
  DateTime? _dueTime;

  void _resetInputs() {
    _taskNameController.clear();
    setState(() {
      _dueTime = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDueTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueTime) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        setState(() {
          _dueTime = DateTime(picked.year, picked.month, picked.day,
              selectedTime.hour, selectedTime.minute);
        });
      }
    }
  }

  void _saveTask(BuildContext context) {
    if (_taskNameController.text.isNotEmpty && _dueTime != null) {
      // Lưu task mới vào provider
      Provider.of<ListTask>(context, listen: false).addTask(
        _taskNameController.text,
        _dueTime!,
      );

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Success'),
                content: Text('Task created successfully.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Reset inputs sau khi đóng thông báo
                      _resetInputs();
                    },
                    child: Text('OK'),
                  ),
                ],
              ));
      // Navigator.of(context).pop();
    } else {
      // Hiển thị thông báo nếu thông tin không đủ
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Missing Information'),
          content: Text('Please provide both task name and due time.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppBar(
          title: Text('Add New Task'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _taskNameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_dueTime == null
                        ? 'Select Due Date'
                        : 'Due Date: ${DateFormat('dd/MM/yyyy HH:mm').format(_dueTime!)}'),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDueTime(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveTask(context),
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
