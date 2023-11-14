import 'package:hive/hive.dart';
part 'tasks_model.g.dart';

@HiveType(typeId: 0)
class TasksModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime endDate;

  @HiveField(4)
  bool isCompleted;

  TasksModel({required this.title, required this.description, required this.startDate, required this.endDate, required this.isCompleted});
}