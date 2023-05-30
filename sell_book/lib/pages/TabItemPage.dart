import 'package:flutter/material.dart';
import 'package:sell_book/pages/DetailsPage.dart';
import 'package:sell_book/pages/HomePage.dart';
import 'package:sell_book/pages/LogOut.dart';
import 'package:sell_book/pages/LoginPage.dart';
import 'package:sell_book/pages/SearchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabItemPage extends StatefulWidget {
  const TabItemPage({super.key});

  @override
  State<TabItemPage> createState() => _TabItemPageState();
}

enum TabItem {
  home,
  search,
  details,
}

class _TabItemPageState extends State<TabItemPage> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, Widget> _pageWidgets = {
    TabItem.home: const HomePage(),
    TabItem.search: SearchPage(),
    TabItem.details: DetailsPage(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 45.0,
        title: Text(
          'SELL BOOK',
          style: TextStyle(color: Color.fromARGB(255, 247, 246, 246)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LogOut(),
                  ));
            },
            child: Icon(Icons.account_circle_rounded),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: _pageWidgets[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: TabItem.values.indexOf(_currentTab),
        onTap: (int index) {
          _selectTab(TabItem.values[index]);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Details',
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  void logOut(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }
}
