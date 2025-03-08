import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final types.User _currentUser = const types.User(id: '1');
  final types.User _otherUser = const types.User(id: '2');
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addInitialMessages();
  }

  void _addInitialMessages() {
    final textMessage = types.TextMessage(
      id: const Uuid().v4(),
      author: _otherUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: 'Hello! How can I help you?',
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  void _handleSendPressed(String text) {
    if (text.trim().isEmpty) return;

    final textMessage = types.TextMessage(
      id: const Uuid().v4(),
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    setState(() {
      _messages.insert(0, textMessage);
      _textController.clear();
    });
  }

  Future<void> _handleImageSelection() async {
    final ImagePicker picker = ImagePicker();
    final XFile? result = await picker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      final imageMessage = types.ImageMessage(
        id: const Uuid().v4(),
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        uri: result.path,
        name: result.name,
        size: File(result.path).lengthSync(),
      );

      setState(() {
        _messages.insert(0, imageMessage);
      });
    }
  }

  Future<void> _handleFileSelection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final fileMessage = types.FileMessage(
        id: const Uuid().v4(),
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: result.files.single.name,
        uri: result.files.single.path!,
        size: result.files.single.size,
      );

      setState(() {
        _messages.insert(0, fileMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: (types.PartialText message) =>
                  _handleSendPressed(message.text),
              user: _currentUser,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.blue),
                  onPressed: _handleImageSelection,
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.blue),
                  onPressed: _handleFileSelection,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () => _handleSendPressed(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
