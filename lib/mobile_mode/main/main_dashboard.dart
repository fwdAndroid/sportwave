import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/mobile_mode/generate/genearate_app.dart';
import 'package:sportwave/mobile_mode/main/faq_mobile_page.dart';
import 'package:sportwave/mobile_mode/main/home_page_mobile.dart';
import 'package:sportwave/mobile_mode/main/news_page_mobile.dart';
import 'package:sportwave/mobile_mode/main/setting_mobile_page.dart';
import 'package:sportwave/utils/colors.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  int _selectedTab = 0;

  List _pages = [
    const HomePageMobile(),
    const NewsPageMobile(),
    const FaqMobilePage(),
    GenerateApp(),
    const SettingMobilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false; // Return false to prevent closing the app
      },
      child: Scaffold(
        backgroundColor: mainBtnColor,
        body: _pages[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                  color: black,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.newspaper,
                  color: black,
                ),
                label: "News"),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.query_builder,
                  color: black,
                ),
                label: "FAQ"),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.airplane_ticket,
                  color: black,
                ),
                label: "Generate"),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings,
                  color: black,
                ),
                label: "Settings"),
          ],
          backgroundColor:
              mainBtnColor, // Set the background color for the nav bar
          selectedIconTheme: IconThemeData(color: mainBtnColor),
          onTap: (index) => _changeTab(index),
          currentIndex: _selectedTab,
        ),
      ),
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
