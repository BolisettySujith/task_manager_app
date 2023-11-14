import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_app_flutter/data/boxes.dart';
import 'package:task_app_flutter/models/tasks_model.dart';

import '../data/network/calender_api_services.dart';

class TaskManagerViewModel extends ChangeNotifier {
  late Box<TasksModel> _notesBox;
  late final CalendarClient _calendarClient;

  TaskManagerViewModel(this._calendarClient) {
    _notesBox = Boxes.getData();
  }

  List<TasksModel> get notes => _notesBox.values.toList();

  Future<void> addTask(TasksModel task) async {
    await _notesBox.add(task);
    // Add the task to Google Calendar
    await _calendarClient.insert(task.title, task.startDate, task.endDate);

    notifyListeners();
  }

  Future<void> deleteTask(TasksModel task) async {
    await task.delete();
    notifyListeners();
  }

  int getCompletedTaskCount() {
    return notes.where((task) => task.isCompleted).length;
  }

  void updateTaskCompletion(TasksModel notesModel, bool isCompleted) async {
    notesModel.isCompleted = isCompleted;
    await notesModel.save();
    notifyListeners();
  }

  List<TasksModel> getSortedTasksByStartDate() {
    List<TasksModel> sortedTasks = List.from(notes);
    sortedTasks.sort((a, b) => a.startDate.compareTo(b.startDate));
    return sortedTasks;
  }

  List<TasksModel> getUpcomingTasks() {
    DateTime today = DateTime.now();

    List<TasksModel> upcomingTasks = notes.where((task) {
      // Truncate milliseconds for accurate comparison
      DateTime truncatedStartDate = DateTime(
        task.startDate.year,
        task.startDate.month,
        task.startDate.day
      );

      DateTime truncatedToday = DateTime(
        today.year,
        today.month,
        today.day,
      );

      return (task.startDate.isAfter(today) && !task.isCompleted) || (truncatedStartDate.isAtSameMomentAs(truncatedToday) && !task.isCompleted);
    }).toList();

    // Sort the upcoming tasks by start date in ascending order
    upcomingTasks.sort((a, b) => a.startDate.compareTo(b.startDate));

    // Limit the result to the first 4 tasks
    return upcomingTasks.take(4).toList();
  }

  List<TasksModel> getOngoingTasks() {
    DateTime today = DateTime.now();

    List<TasksModel> ongoingTasks = notes.where((task) {
      DateTime truncatedStartDate = DateTime(
        task.startDate.year,
        task.startDate.month,
        task.startDate.day,
      );

      DateTime truncatedToday = DateTime(
        today.year,
        today.month,
        today.day,
      );

      return truncatedStartDate.isAtSameMomentAs(truncatedToday) && !task.isCompleted;
    }).toList();

    // Sort the ongoing tasks by start date in ascending order
    ongoingTasks.sort((a, b) => a.startDate.compareTo(b.startDate));

    return ongoingTasks;
  }

}