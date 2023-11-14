import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_app_flutter/res/app_colors.dart';
import 'package:task_app_flutter/res/app_constants.dart';
import 'package:task_app_flutter/view/home_screen.dart';
import 'package:task_app_flutter/view/my_task_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;

  var screens = [
    const HomeScreen(),
    const MyTasksScreen()
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            if(currentIndex !=0){
              changePage(0);
              return false;
            }
            return true;
          },
          child: screens[currentIndex]
      ),
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: AppColors.bottomBarBackgroundColor,
        hasNotch: true,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: 8,
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: AppColors.bottomBarActiveBackgroundColor,
              icon: Icon(Icons.home_filled, color: AppColors.bottomBarIconColor,),
              activeIcon: Icon(Icons.home_filled, color: AppColors.bottomBarActiveColor,),
              title: Text(AppConstants.homeBottomBarText, style: TextStyle(color: AppColors.bottomBarActiveColor),)
          ),
          BubbleBottomBarItem(
              backgroundColor: AppColors.bottomBarActiveBackgroundColor,
              icon: Icon(Icons.book, color: AppColors.bottomBarIconColor,),
              activeIcon: Icon(Icons.book, color: AppColors.bottomBarActiveColor,),
              title: Text(AppConstants.myTasksBottomBarText, style: TextStyle(color: AppColors.bottomBarActiveColor),)
          ),
        ],
      ),
    );
  }
  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }
}
