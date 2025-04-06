import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../Services/chatService.dart';
import '../core/databases/cache/cache_helper.dart';

class ChatController with ChangeNotifier {
  final ChatService _chatService = ChatService();
  List<types.Message> _messages = [];
  String? _userEmail;

  List<types.Message> get messages => _messages;
  String? get userEmail => _userEmail;

  Future<void> fetchMessages() async {
    _userEmail = await CacheHelper().getDataString(key: 'email');
    if (_userEmail == null) return;

    final fetchedMessages = await _chatService.getMessages(_userEmail!);
    _messages = fetchedMessages;
    notifyListeners();
  }

  Future<void> sendMessage(String content, String receiverEmail) async {
    if (_userEmail == null) return;
    await _chatService.sendMessage(_userEmail!, receiverEmail, content);
    await fetchMessages();
  }
}
