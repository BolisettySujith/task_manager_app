import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app_flutter/res/components/task_details.dart';

import '../../models/tasks_model.dart';
import 'get_tag_widget.dart';

Widget onGoingTasksComponent(String title, List<TasksModel> tasks, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (tasks.isNotEmpty)
        Column(
          children: tasks.map((nm) {
            return GestureDetector(
              onTap: (){
                showTaskDetailsDialog(context, nm);
              },
              child: Card(
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
              ),
            );
          }).toList(),
        ),
      if (tasks.isEmpty)
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "No tasks",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
    ],
  );
}