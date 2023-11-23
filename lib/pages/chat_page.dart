import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String username = ''; // New variable to store the username

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
      print('Error fetching username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username.isNotEmpty ? username : widget.receiverUserEmail),
      ),
    );
  }
}