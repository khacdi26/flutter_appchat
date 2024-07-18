import 'package:cloud_firestore/cloud_firestore.dart';

// import 'file.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String? message;
  final List<String>? fileURLs;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    this.message,
    this.fileURLs,
    required this.timestamp,
    // this.files,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'fileURLs': fileURLs,
      'timeStamp': timestamp,
    };
  }
}
