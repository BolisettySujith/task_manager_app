import 'package:flutter/material.dart';
import 'package:task_app_flutter/models/tasks_model.dart';

void showTaskDetailsDialog(BuildContext context, TasksModel task) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(task.title),
        content: Text(task.description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),),
          ),
        ],
      );
    },
  );
}