import 'package:convo/model/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // Fetch the sender's username
    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();

    final Timestamp timestamp = Timestamp.now();

    String currentUserUsername = userSnapshot['username'] ?? 'Unknown';

    Message newMessage = Message(
      senderId: currentUserId,
      senderUsername: currentUserUsername,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Include the sender's username in the message data
    Map<String, dynamic> messageData = newMessage.toMap();
    messageData['senderUsername'] = currentUserUsername;

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(messageData);
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}