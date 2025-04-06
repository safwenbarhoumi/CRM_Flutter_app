import 'package:flutter/material.dart';
import '../core/databases/cache/cache_helper.dart';
import 'Chat/chat_list_screen.dart';
import 'Doctor/screens/home_screen.dart';
import 'DoctorSpace/views/home.dart';
import 'profile/views/profile_screen.dart';

class NavigationBottomBar extends StatefulWidget {
  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _selectedIndex = 0;
  String? patientEmail;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    patientEmail = CacheHelper().getDataString(key: 'email');
    // Initialize the _pages list after patientEmail is set

    _pages = [
      HomeDoctorScreen(),
      HomePage(),
      ChatListScreen(userEmail: patientEmail ?? ''),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIconWithBadge(IconData icon, int count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 28),
        if (count > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.isNotEmpty
          ? _pages[_selectedIndex]
          : Container(), // Check if _pages is populated
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithBadge(
                Icons.calendar_today, 9), // Appointments with badge
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithBadge(Icons.chat, 5), // Chat with badge
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
