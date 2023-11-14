import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_app_flutter/res/app_colors.dart';
import 'package:task_app_flutter/res/app_constants.dart';
import '../models/tasks_model.dart';
import '../res/components/task_card.dart';
import '../res/components/task_details.dart';
import '../view_model/task_manager_view_model.dart';
import 'create_task_screen.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.myTasksAppBarText),
        backgroundColor: AppColors.appBarBackgroundColor,
        foregroundColor: AppColors.appBarForegroundColor,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTask()));
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 20,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<TaskManagerViewModel>(
              builder: (context, viewModel, _) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.yourTasksContainerColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                    )
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                AppConstants.yourTasksText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                              ),
                            ),
                            Text(
                              "Completed Tasks ${viewModel.getCompletedTaskCount()} / ${viewModel.notes.length}",
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            )
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 5.0,
                          percent: viewModel.notes.isEmpty ? 0 : viewModel.getCompletedTaskCount()/viewModel.notes.length,
                          center: Text(
                            viewModel.notes.isEmpty ? "0%" : "${((viewModel.getCompletedTaskCount()/viewModel.notes.length)*100).round()}%",
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                          progressColor: AppColors.activeProgressColor,
                          backgroundColor: AppColors.progressbarBackgroundColor,
                        )
                      ],
                    ),
                  )
                );
              }
            ),
            Consumer<TaskManagerViewModel>(
              builder: (context, viewModel, _) {
                List<TasksModel> sortedTasks = viewModel.getSortedTasksByStartDate();
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: sortedTasks.length,
                  itemBuilder: (context, index) {
                    TasksModel nm = sortedTasks[index];
                    return Dismissible(
                      key: Key(nm.title),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        viewModel.deleteTask(nm);
                      },
                      background: Container(color: AppColors.dismissibleBackgroundColor),
                      child: GestureDetector(
                        onTap: (){
                          showTaskDetailsDialog(context, nm);
                        },
                        child: taskCard(nm, context)
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
