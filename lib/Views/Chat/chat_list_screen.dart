import 'package:flutter/material.dart';
import 'chat.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chats = [
    {
      "name": "Mohamed",
      "message": "Even dead I'm the hero.",
      "time": "5:00 PM",
      "image": "assets/iron_man.png"
    },
    {
      "name": "Kaptan ",
      "message": "Hey, how’s it going?",
      "time": "4:30 PM",
      "image": "assets/captain_america.png"
    },
    {
      "name": "Sabir Man",
      "message": "I’m exposed now. Please help!",
      "time": "2:00 PM",
      "image": "assets/spider_man.png"
    },
    {
      "name": "Halim",
      "message": "HULK SMASH!!",
      "time": "1:30 PM",
      "image": "assets/hulk.png"
    },
    {
      "name": "Tarek",
      "message": "I'm hitting the gym bro.",
      "time": "12:30 PM",
      "image": "assets/thor.png"
    },
    {
      "name": "Salma",
      "message": "My twins are giving me a headache.",
      "time": "11:30 AM",
      "image": "assets/scarlet_witch.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.purple.shade100,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) => const ChatScreen(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(chats[index]["image"]!),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  chats[index]["name"]!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  chats[index]["message"]!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                trailing: Text(
                  chats[index]["time"]!,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
