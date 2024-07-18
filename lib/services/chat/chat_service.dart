import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_chat/models/message.dart';

class ChatService {
  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  /* 
  List<Map<String, dynamic>> = [
  { string : dynamic
    'email': test@gmail.com,    
    'id': ...                  
  },
  {
    'email': ronaldo@gmail.com, 
    'id': ...                   
  }, ... ]
  
  */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message (id nguoi nhan - tin nhan)
  Future<void> sendMessage(String receiverID,
      {String? message, List<String>? files}) async {
    // // get current user infor
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      fileURLs: files,
      timestamp: timestamp,
    );

    // //construct chat room ID for the two user (rút gọn để đảm bảo tính duy nhất)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Future<List<String>> uploadFiles(List<File> files) async {
    List<String> fileURLs = [];

    for (File file in files) {
      try {
        String fileName = file.path.split('/').last;
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('uploads/$fileName');
        await firebaseStorageRef.putFile(file);
        String downloadURL = await firebaseStorageRef.getDownloadURL();
        fileURLs.add(downloadURL);
      } catch (e) {
        rethrow;
      }
    }

    return fileURLs;
  }

  // //get message
  // Stream<QuerySnapshot> getMessages(String userID, ortherUserID) {
  //   List<String> ids = [userID, ortherUserID];
  //   ids.sort();
  //   String chatRoomID = ids.join('_');

  //   return _firestore
  //       .collection("chat_rooms")
  //       .doc(chatRoomID)
  //       .collection("messages")
  //       .orderBy("timeStamp", descending: true)
  //       .limit(20)
  //       .snapshots();
  // }
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID,
      {DocumentSnapshot? lastVisible}) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    Query query = _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timeStamp", descending: true)
        .limit(15);

    if (lastVisible != null) {
      query = query.startAfterDocument(lastVisible);
    }

    return query.snapshots();
  }
}
