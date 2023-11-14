import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/tasks_model.dart';
import '../../view_model/task_manager_view_model.dart';
import 'get_tag_widget.dart';

Widget taskCard(TasksModel nm, BuildContext context) {
  return Card(
    color: Colors.white,
    elevation: 0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            nm.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.access_time_filled,
                color: Colors.indigo,
                size: 15,
              ),
              const SizedBox(width: 5,),
              Text(
                "${nm.startDate.day} ${DateFormat('MMM').format(DateTime(0,nm.startDate.month))}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14
                ),
                maxLines: 2,
              ),
              Text(
                " - ",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "${nm.endDate.day} ${DateFormat('MMM').format(DateTime(0,nm.endDate.month))}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14
                ),
                maxLines: 2,
              ),
            ],
          ),
          trailing: Wrap(
            spacing: 20,
            children: [
              // GestureDetector(
              //   onTap: () {
              //
              //   },
              //   child: const Icon(Icons.edit),
              // ),
              GestureDetector(
                onTap: () {
                  Provider.of<TaskManagerViewModel>(context, listen: false).updateTaskCompletion(nm, !nm.isCompleted ?? false);
                },
                child: Icon(
                  nm.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: nm.isCompleted ? Colors.green : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            children: [
              nm.isCompleted ? getTag("Done", Colors.blue.shade100) : getTag("On Going", Colors.red.shade100)
            ],
          ),
        ),
        const SizedBox(height: 10,)
      ],
    ),
  );
}