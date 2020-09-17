import 'package:flutter/material.dart';
import 'package:tennist/pages/tab_1/main/Tab1Main.screen.dart';
import 'package:tennist/pages/tab_2/main/Tab2Main.screen.dart';
import 'package:tennist/pages/tab_3/main/Tab3Main.screen.dart';

class BottomNaviController extends StatefulWidget {
  static const String routeName = '/bottomNavi';
  @override
  _BottomNaviControllerState createState() => _BottomNaviControllerState();
}

class _BottomNaviControllerState extends State<BottomNaviController> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  final List<Widget> _widgets = <Widget>[
    Tab1MainScreen(),
    // Tab2MainScreen(),
    Tab3MainScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/images/tabbar/tennis-unselected.png',
              scale: 1.7,
            ),
            activeIcon: new Image.asset(
              'assets/images/tabbar/tennis-selected.png',
              scale: 1.7,
            ),
            title: Text(
              'Tennist',
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: new Image.asset(
          //     'assets/images/tabbar/tennis-unselected.png',
          //     scale: 1.7,
          //   ),
          //   activeIcon: new Image.asset(
          //     'assets/images/tabbar/tennis-selected.png',
          //     scale: 1.7,
          //   ),
          //   title: Text(
          //     'Racket',
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/images/tabbar/account-unselected.png',
              scale: 1.7,
            ),
            activeIcon: new Image.asset(
              'assets/images/tabbar/account-selected.png',
              scale: 1.7,
            ),
            title: Text(
              'Mypage',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xff141414),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: _widgets,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
