import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/mobile_mode/main/faq_mobile_page.dart';
import 'package:sportwave/mobile_mode/main/home_page_mobile.dart';
import 'package:sportwave/mobile_mode/main/news_page_mobile.dart';
import 'package:sportwave/mobile_mode/main/setting_mobile_page.dart';
import 'package:sportwave/utils/colors.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePageMobile(),
    NewsPageMobile(),
    FaqMobilePage(),
    SettingMobilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: mainBtnColor),
          backgroundColor: mobileBackgroundColor,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color:
                    _currentIndex == 0 ? mobileBackgroundColor : textformColor,
              ),
              label: 'Home',
              backgroundColor: colorwhite,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper,
                color:
                    _currentIndex == 1 ? mobileBackgroundColor : textformColor,
              ),
              label: 'News',
              backgroundColor: colorwhite,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.query_builder,
                color:
                    _currentIndex == 2 ? mobileBackgroundColor : textformColor,
              ),
              label: 'FAQ',
              backgroundColor: colorwhite,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color:
                    _currentIndex == 3 ? mobileBackgroundColor : textformColor,
              ),
              label: 'Settings',
              backgroundColor: colorwhite,
            ),
          ],
        ),
      ),
    );
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> _showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
