import 'package:flutter/material.dart';

class ManageUsers extends StatelessWidget {
  final List<Map<String, String>> users = [
    {"name": "John Doe", "role": "Patient"},
    {"name": "Dr. Emily Smith", "role": "Doctor"},
    {"name": "Admin Joe", "role": "Admin"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(child: Text(user['name']![0])),
            title: Text(user['name']!),
            subtitle: Text("Role: ${user['role']}"),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // open user details
            },
          ),
        );
      },
    );
  }
}
