import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'tabs/delivery.dart';
import 'tabs/deposit.dart';
import 'tabs/home.dart';
import 'tabs/withdraw.dart';

class Dashboard extends StatefulWidget {
  static final String id = "dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  List<Widget> _widgetoption = [
    // Dashboard(),
    Home(),
    Deposit(),
    Withdraw(),
  ];

  void _onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: kContentDarkTheme,
        showUnselectedLabels: true,
        fixedColor: kPrimaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Deposit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.downloading),
            label: "Withdraw",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTap,
      ),
      body: _widgetoption.elementAt(selectedIndex),
    );
  }
}
