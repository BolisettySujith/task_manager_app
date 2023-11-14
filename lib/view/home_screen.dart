import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app_flutter/res/app_colors.dart';
import 'package:task_app_flutter/res/app_constants.dart';
import 'package:task_app_flutter/view/create_task_screen.dart';
import '../models/tasks_model.dart';
import '../res/components/ongoing_task_widget.dart';
import '../res/components/upcoming_task_widget.dart';
import '../view_model/task_manager_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${DateFormat('MMM').format(DateTime(0,DateTime.now().month))} ${DateTime.now().day}, ${DateTime.now().year}",
          style: const TextStyle(
            fontSize: 16
          ),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 20,)
        ],
      ),
      body: Consumer<TaskManagerViewModel>(
        builder: (context, viewModel, _) {
          List<TasksModel> upcomingTasks = viewModel.getUpcomingTasks();
          List<TasksModel> ongoingTasks = viewModel.getOngoingTasks();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upcoming Tasks
                  upcomingTaskComponent(AppConstants.upcomingTaskText, upcomingTasks, context),
                  const SizedBox(height: 20,),
                  // Ongoing Tasks
                  onGoingTasksComponent(AppConstants.onGoingTaskText, ongoingTasks, context),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.floatingActionButtonBackgroundColor,
        foregroundColor: AppColors.floatingActionButtonForegroundColor,
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTask()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
