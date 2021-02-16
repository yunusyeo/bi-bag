import 'package:flutter/material.dart';
import 'package:hello_word/model/User.dart';
import 'package:hello_word/provider/UserProvider.dart';
import 'package:hello_word/ui/tabs/MyAdvertisementPage.dart';
import 'package:hello_word/ui/tabs/MyInboxPage.dart';
import 'package:hello_word/ui/tabs/MyProfilePage.dart';
import 'package:hello_word/ui/tabs/AddAdvertisementPage.dart';
import 'package:hello_word/ui/tabs/SearchAdvertisementPage.dart';
import 'package:hello_word/values/Strings.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final tabs = [
    MyAdvertisementPage(),
    SearchAdvertisementPage(),
    AddAdvertisementPage(),
    MyInboxPage(),
    MyProfilePage(),
  ];

  final List<String> titleList = [
    Strings.myAvdvertsPage,
    Strings.searchAdvertpage,
    Strings.postAdvertisePage,
    Strings.myInboxPage,
    Strings.myProfilePage
  ];

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(titleList[_currentIndex]),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.ad_units),
              label: Strings.myAvdvertsPage,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: Strings.searchAdvertpage,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: Strings.postAdvertisePage,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: Strings.myInboxPage,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: Strings.myProfilePage,
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
