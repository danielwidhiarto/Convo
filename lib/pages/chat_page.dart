import 'package:convo/components/chat_bubble.dart';
import 'package:convo/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/text_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiveUserID;

  const ChatPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiveUserID,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String username = ''; // New variable to store the username
  DateTime? _previousTimestamp;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiveUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsername(); // Fetch the username when the widget is initialized
  }

  Future<void> fetchUsername() async {
    try {
      // Fetch the username based on the receiveUserID
      DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(widget.receiveUserID).get();

      if (userSnapshot.exists) {
        setState(() {
          username = userSnapshot['username'];
        });
      }
    } catch (e) {
      // print('Error fetching username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username.isNotEmpty ? username : widget.receiverUserEmail),
      ),
      body:  Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),

          _buildMessageInput(),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessage(
          widget.receiveUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    DateTime timestamp = (data['timestamp'] as Timestamp).toDate();

    bool showTimestamp = _shouldShowTimestamp(timestamp);
    _previousTimestamp = timestamp;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            // Display sender's username and timestamp if it should be shown
            if (showTimestamp) ...[
              Row(
                mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  // Text(data['senderUsername']),
                  // SizedBox(width: 8),
                  Text(
                    _formatTimestamp(timestamp),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
            const SizedBox(
              height: 5,
            ),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  bool _shouldShowTimestamp(DateTime currentTimestamp) {
    return _previousTimestamp == null ||
        currentTimestamp.difference(_previousTimestamp!) > Duration(minutes: 1);
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format timestamp to display in a readable way
    String formattedTime =
        "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _messageController,
              hintText: "Enter a message",
              obscureText: false,
            ),
          ),

          IconButton(onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward,
            size: 40,),
          )
        ],
      ),
    );
  }
}
