import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../barcode_scanner.dart';
import '../pages/food_log_page.dart';
import '../pages/home_page.dart';
import '../pages/sleep_log_page.dart';
import '../pages/user_page.dart';

class MainBottomNavBarController extends StatefulWidget {
  static int index = 1;
  MainBottomNavBarController();

  @override
  _MainBottomNavBarControllerState createState() =>
      _MainBottomNavBarControllerState();
}

class _MainBottomNavBarControllerState
    extends State<MainBottomNavBarController> {
  final PageStorageBucket storageBucket = PageStorageBucket();
  List<Widget> pageList = [
    HomePage(key: PageStorageKey("Home")),
    ChangeNotifierProvider(
        create: (context) => BarcodeProvider(),
        child: FoodLogPage(key: PageStorageKey("FoodLog"))),
    SleepLogPage(key: PageStorageKey("SleepLog")),
    UsersPage(key: PageStorageKey("UsersPage"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomNavBar(),
        body: IndexedStack(
          index: MainBottomNavBarController.index,
          children: pageList,
        )
        // body: PageStorage(
        //   child: pageList[MainBottomNavBarController.index],
        //   bucket: storageBucket,
        // ),
        );
  }

  void itemSelected(int newIndex) {
    if (MainBottomNavBarController.index == newIndex) {
      return; // Don't reload the current page
    }

    setState(() {
      MainBottomNavBarController.index = newIndex;
    });
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
        onTap: itemSelected,
        currentIndex: MainBottomNavBarController.index,
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

// class MainBottomNavBar extends StatefulWidget {
//   MainBottomNavBar();

//   @override
//   _MainBottomNavBarState createState() => _MainBottomNavBarState();
// }

// class _MainBottomNavBarState extends State<MainBottomNavBar> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   void itemSelected(int newIndex) {
//     if (MainBottomNavBarController.index == newIndex) {
//       return; // Don't reload the current page
//     }

//     setState(() {
//       MainBottomNavBarController.index = newIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         onTap: itemSelected,
//         currentIndex: MainBottomNavBarController.index,
//         backgroundColor: Theme.of(context).accentColor,
//         fixedColor: Theme.of(context).bottomAppBarColor,
//         // selectedItemColor: Theme.of(context).focusColor,
//         // unselectedItemColor: Theme.of(context).dividerColor,
//         type: BottomNavigationBarType.fixed,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fastfood), title: Text("Food Log")),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.hotel), title: Text("Sleep Log")),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.portrait), title: Text("User Profile"))
//         ]);
//   }
// }
