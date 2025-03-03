import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoCall extends StatefulWidget {
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final TextEditingController roomController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  static const platform = MethodChannel('com.example.zoom');

  @override
  void dispose() {
    super.dispose();
  }

  void _joinMeeting() async {
    try {
      // Sending data to native code to join Zoom meeting
      await platform.invokeMethod('joinMeeting', {
        'room': roomController.text,
        'name': nameController.text,
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zoom Video Call")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: roomController,
              decoration: InputDecoration(labelText: "Room Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Your Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _joinMeeting,
              child: Text("Join Meeting"),
            ),
          ],
        ),
      ),
    );
  }
}
