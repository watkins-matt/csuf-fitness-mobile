import 'package:csuf_fitness/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/settings_page.dart';
import '../pages/home_page.dart';
import '../pages/sleep_log_page.dart';
import '../pages/food_log_page.dart';

class MainBottomNavBar extends StatefulWidget {
  MainBottomNavBar();

  @override
  _MainBottomNavBarState createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  static int index = 0;

  @override
  void initState() {
    super.initState();
  }

  void itemSelected(int newIndex) {
    if (index == newIndex) {
      return; // Don't reload the current page
    }

    setState(() {
      index = newIndex;

      switch (index) {
        case 1:
          HomePage.push(context);
          break;
        case 2:
          FoodLogPage.push(context);
          break;
        case 3:
          SleepLogPage.push(context);
          break;
        case 4:
          UsersPage.push(context);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: itemSelected,
        currentIndex: index,
        backgroundColor: Theme.of(context).accentColor,
        fixedColor: Theme.of(context).bottomAppBarColor,
        // selectedItemColor: Theme.of(context).focusColor,
        // unselectedItemColor: Theme.of(context).dividerColor,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text("Food Log")),
          BottomNavigationBarItem(
              icon: Icon(Icons.hotel), title: Text("Sleep Log")),
          BottomNavigationBarItem(
              icon: Icon(Icons.portrait), title: Text("User Profile"))
        ]);
  }
}
