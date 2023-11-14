import 'package:flutter/material.dart';
import 'package:task_app_flutter/res/app_colors.dart';
import 'package:task_app_flutter/res/components/task_details.dart';
import '../../models/tasks_model.dart';


Widget upcomingTaskComponent(String title, List<TasksModel> tasks, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      if (tasks.isNotEmpty)
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 12.0,
          runSpacing: 12.0,
          children: tasks.asMap().entries.map((entry) {
            int index = entry.key;
            TasksModel task = entry.value;
            return upcomingTaskContainer(task, AppColors.upcomingTasksColors[index], context);
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


Widget upcomingTaskContainer(TasksModel task, Color randomColor, BuildContext context) {
  return GestureDetector(
    onTap: (){
      showTaskDetailsDialog(context, task);
    },
    child: FittedBox(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: randomColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: randomColor.withOpacity(0.4),
              offset: const Offset(0.0, 0.0),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width*0.38,
          child: Center(
            child: Text(
              task.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

