import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatService {
  final String baseUrl = 'http://192.168.1.104:8091/conversations';

  Future<List<types.Message>> getMessages(String userEmail) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userEmail'));
    if (response.statusCode == 200) {
      final List<dynamic> conversations = jsonDecode(response.body);
      List<types.Message> messages = [];
      for (var conv in conversations) {
        for (var msg in conv['messages']) {
          messages.add(
            types.TextMessage(
              id: msg['id'] ?? UniqueKey().toString(),
              author: types.User(id: msg['senderEmail']),
              text: msg['content'],
              createdAt:
                  DateTime.parse(msg['timestamp']).millisecondsSinceEpoch,
            ),
          );
        }
      }
      return messages;
    }
    return [];
  }

  Future<void> sendMessage(
      String senderEmail, String receiverEmail, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send-message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'senderEmail': senderEmail,
        'receiverEmail': receiverEmail,
        'content': content,
        'type': 'TEXT',
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
