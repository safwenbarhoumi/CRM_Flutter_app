import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<ConversationModel>> fetchUserConversations(String userEmail) async {
  final response = await http.get(
    Uri.parse('http://192.168.1.104:8091/conversations/user/$userEmail'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => ConversationModel.fromJson(json)).toList();
  } else {
    throw Exception('Échec du chargement des conversations pour $userEmail');
  }
}

class ConversationModel {
  final String id;
  final String? doctorId;
  final String? patientId;
  final String lastMessageTime;
  final String lastMessageContent;
  final String lastMessageSender;
  final String? doctorPhoto;
  final String? patientPhoto;
  final String doctorEmail;
  final String patientEmail;
  final List<MessageModel> messages;
  final String lastMessageTimeFormatted;

  ConversationModel({
    required this.id,
    this.doctorId,
    this.patientId,
    required this.lastMessageTime,
    required this.lastMessageContent,
    required this.lastMessageSender,
    this.doctorPhoto,
    this.patientPhoto,
    required this.doctorEmail,
    required this.patientEmail,
    required this.messages,
    required this.lastMessageTimeFormatted,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? "",
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      lastMessageTime: json['lastMessageTime'] ?? "",
      lastMessageContent: json['lastMessageContent'] ?? "",
      lastMessageSender: json['lastMessageSender'] ?? "",
      doctorPhoto: json['doctorPhoto'],
      patientPhoto: json['patientPhoto'],
      doctorEmail: json['doctorEmail'] ?? "",
      patientEmail: json['patientEmail'] ?? "",
      messages: (json['messages'] as List?)
              ?.map((message) => MessageModel.fromJson(message))
              .toList() ??
          [],
      lastMessageTimeFormatted: json['lastMessageTimeFormatted'] ?? "",
    );
  }
}

class MessageModel {
  final String? id;
  final String senderEmail;
  final String? conversationId;
  final String? senderId;
  final String content;
  final String messageType;
  final String timestamp;
  final String timestampFormatted;
  final String senderName;

  MessageModel({
    this.id,
    required this.senderEmail,
    this.conversationId,
    this.senderId,
    required this.content,
    required this.messageType,
    required this.timestamp,
    required this.timestampFormatted,
    required this.senderName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderEmail: json['senderEmail'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      content: json['content'],
      messageType: json['messageType'],
      timestamp: json['timestamp'],
      timestampFormatted: json['timestampFormatted'],
      senderName: json['senderName'],
    );
  }
}
