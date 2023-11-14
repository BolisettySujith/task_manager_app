import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_app_flutter/res/app_constants.dart';
import 'package:task_app_flutter/view/main_screen.dart';
import 'package:task_app_flutter/view_model/task_manager_view_model.dart';
import 'data/network/calender_api_services.dart';
import 'models/tasks_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(TasksModelAdapter());
  await Hive.openBox<TasksModel>("tasks");

  // Create an instance of CalendarClient
  CalendarClient calendarClient = CalendarClient();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskManagerViewModel(calendarClient),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
