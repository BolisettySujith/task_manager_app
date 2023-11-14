import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app_flutter/res/app_colors.dart';
import 'package:task_app_flutter/res/app_constants.dart';
import '../models/tasks_model.dart';
import '../view_model/task_manager_view_model.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    startDate = dateRange.start;
    endDate = dateRange.end;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        foregroundColor: AppColors.appBarForegroundColor,
        title: const Text(AppConstants.createTaskAppBarText),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _taskFields(AppConstants.taskNameText, AppConstants.taskNameFieldHintText, titleController),
              _taskFields(AppConstants.taskDescriptionText, AppConstants.taskDescriptionFieldHintText, descriptionController),
              const SizedBox(height: 10,),
              _date(),
              const SizedBox(height: 20,),
              TextButton(
                onPressed: () {
                  if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                    final data = TasksModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        startDate: startDate,
                        endDate: endDate,
                        isCompleted: false
                    );
                    Provider.of<TaskManagerViewModel>(context, listen: false).addTask(data);
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                    elevation: 2,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange
                ),
                child: const Text(
                    AppConstants.saveButtonText
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskFields(String title, String hint, TextEditingController controller){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 15),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            focusColor: Colors.black,
            fillColor: Colors.grey.shade200,
            hintText: hint,
            hintStyle:
            const TextStyle(color: Colors.grey, fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.cyan),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Colors.transparent),
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _date(){
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppConstants.taskDatesTitleText,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade800,
                  size: 16,
                ),
                const SizedBox(width: 5,),
                Text(
                  "${startDate.day} ${DateFormat('MMM').format(DateTime(0,startDate.month))} ${startDate.year}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),
                  maxLines: 2,
                ),
                Text(
                  " - ",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "${endDate.day} ${DateFormat('MMM').format(DateTime(0,endDate.month))} ${endDate.year}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),
                  maxLines: 2,
                ),
                const Spacer(flex: 1,),
                FittedBox(
                  child: GestureDetector(
                      onTap: pickDateRange,
                      child: const Text(
                        AppConstants.changeDateButtonText,
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year+50),
        builder: (context, child){
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: AppColors.datePickerThemeColorScheme,
              ),
              child: child!
          );
        }
    );

    if(newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
    });
  }
}
