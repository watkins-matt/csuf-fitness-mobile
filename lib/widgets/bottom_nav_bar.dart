import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    setState(() {
      index = newIndex;
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
