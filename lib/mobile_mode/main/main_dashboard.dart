import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomePageMobile(),
      NewsPageMobile(),
      FaqMobilePage(),
      SettingMobilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: mobileBackgroundColor,
        inactiveColorPrimary: textformColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.newspaper),
        activeColorPrimary: mobileBackgroundColor,
        inactiveColorPrimary: textformColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.query_builder),
        activeColorPrimary: mobileBackgroundColor,
        inactiveColorPrimary: textformColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        activeColorPrimary: mobileBackgroundColor,
        inactiveColorPrimary: textformColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false; // Return false to prevent closing the app
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style here
        backgroundColor: colorwhite, // Set the background color for the nav bar
        onItemSelected: (index) {
          setState(() {
            _controller!.index = index;
          });
        },
      ),
    );
  }

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
