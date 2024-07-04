import 'package:cloud_firestore/cloud_firestore.dart';

// import 'file.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  //send file
  // final List<File>? files; // Danh sách các file

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
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
      'timeStamp': timestamp,
      // 'files': files?.map((file) => file.toMap()).toList(),
    };
  }
}
