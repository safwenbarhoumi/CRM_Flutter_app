import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../manage_users.dart';
import 'admin_dashboard.dart';
import 'reports_page.dart';
import 'settings_page.dart';

class AdminNavBar extends StatefulWidget {
  @override
  _AdminNavBarState createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AdminDashboard(),
    ManageUsers(),
    ReportsPage(),
    AdminSettingsPage(),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Iconsax.category), label: "Dashboard"),
    BottomNavigationBarItem(icon: Icon(Iconsax.people), label: "Users"),
    BottomNavigationBarItem(icon: Icon(Iconsax.graph), label: "Reports"),
    BottomNavigationBarItem(icon: Icon(Iconsax.setting), label: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Admin Panel", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: _navItems,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
