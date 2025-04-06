import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _reportCard("System Uptime", "99.98%"),
        _reportCard("Active Users", "1,245"),
        _reportCard("Reports This Month", "89"),
        _reportCard("Incidents Logged", "4"),
      ],
    );
  }

  Widget _reportCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
