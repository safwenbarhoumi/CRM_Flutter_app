import 'package:flutter/material.dart';
import 'Chat/chat_list_screen.dart';
import 'Doctor/screens/home_screen.dart';
import 'DoctorSpace/views/home.dart';
import 'profile/views/profile_screen.dart';

class NavigationBottomBarDoctor extends StatefulWidget {
  @override
  _NavigationBottomBarDoctorState createState() =>
      _NavigationBottomBarDoctorState();
}

class _NavigationBottomBarDoctorState extends State<NavigationBottomBarDoctor> {
  int _selectedIndex = 0;
  // final String? userEmail = "john.doe1@example.com";

  final List<Widget> _pages = [
    // DoctorSpace(),
    // BookingScreen(),
    //HomeDoctorScreen(),
    HomePage(),
    //VideoCall(),
    //ChatListScreen(userEmail: "john.doe1@example.com"),
    //ProfileScreen(),
    //ProfileScreen(),
    // HomePage(),
    // AppointmentsScreen(),
    // ChatScreen(),
    // ProfileScreen(),
  ];

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
      body: _pages[_selectedIndex], // Navigates to the selected screen
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
