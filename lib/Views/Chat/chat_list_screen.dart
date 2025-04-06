import 'package:flutter/material.dart';
import '../../core/databases/api/end_points.dart';
import 'chat.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'chatService.dart';

class ChatListScreen extends StatefulWidget {
  final String userEmail;

  const ChatListScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late Future<List<ConversationModel>> _conversations;

  @override
  void initState() {
    super.initState();
    _conversations = fetchUserConversations(widget.userEmail);
    print("userEmail for the chat : ============> ${widget.userEmail}");
  }

  Future<List<ConversationModel>> fetchUserConversations(
      String userEmail) async {
    final response = await http.get(
      Uri.parse('${EndPoints.baserUrl}/conversations/user/$userEmail'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Échec du chargement des conversations pour $userEmail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.purple.shade100,
        elevation: 2,
      ),
      body: FutureBuilder<List<ConversationModel>>(
        future: _conversations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune conversation trouvée."));
          }

          final chats = snapshot.data!;

          return ListView.builder(
            itemCount: chats.length,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            itemBuilder: (context, index) {
              final conversation = chats[index];
              final image = conversation.doctorPhoto ??
                  conversation.patientPhoto ??
                  "assets/images/default_doctor.png"; // Image par défaut

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      //pageBuilder: (_, __, ___) => const ChatScreen(),
                      pageBuilder: (_, __, ___) => ChatScreen(
                        receiverEmail:
                            conversation.doctorEmail == widget.userEmail
                                ? conversation.patientEmail
                                : conversation.doctorEmail,
                      ),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(image),
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
                      conversation.doctorEmail == widget.userEmail
                          ? conversation.patientEmail
                          : conversation.doctorEmail,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      conversation.lastMessageContent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    trailing: Text(
                      conversation.lastMessageTimeFormatted,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
