import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard, size: 80, color: Colors.blueAccent),
          SizedBox(height: 16),
          Text(
            "Welcome to Admin Dashboard",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Overview of system metrics and activity",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
