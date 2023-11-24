class Message {
  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String message;
  final String timestamp;

  Message({
    required this.senderId,
    required this.senderUsername,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderUsername': senderUsername,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}