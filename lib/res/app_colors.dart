import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> upcomingTasksColors = [
    Colors.orange,
    Colors.pink,
    Colors.lightBlue,
    Colors.purpleAccent,
  ];

  static Color appBarBackgroundColor = Colors.orange.shade300;
  static Color appBarForegroundColor = Colors.white;

  static Color bottomBarBackgroundColor = Colors.white;
  static Color bottomBarActiveBackgroundColor = Colors.orange.shade200;
  static Color bottomBarIconColor = Colors.grey.shade800;
  static Color bottomBarActiveColor = Colors.orange.shade500;

  static Color floatingActionButtonBackgroundColor = Colors.orange.shade300;
  static Color floatingActionButtonForegroundColor = Colors.white;

  static Color yourTasksContainerColor = Colors.orange.shade300;
  static Color activeProgressColor = Colors.orange.shade800;
  static Color progressbarBackgroundColor = Colors.white;

  static Color dismissibleBackgroundColor = Colors.red;

  static ColorScheme datePickerThemeColorScheme = ColorScheme.light(
    primary: Colors.orange.shade400,
    secondary: Colors.orange.shade200,
    onPrimary: Colors.white,
    onSurface: Colors.black,
  );

}