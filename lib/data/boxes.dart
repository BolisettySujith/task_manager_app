import 'package:hive/hive.dart';
import '../models/tasks_model.dart';

class Boxes {
  static Box<TasksModel> getData() => Hive.box<TasksModel>("tasks");
}