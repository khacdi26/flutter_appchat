import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user stream
  /* 
  List<Map<String, dynamic>> = [
  {
    'email': test@gmail.com,    ->   String
    'id': ...                   ->   dynamic
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

  //send message

  //get message
}
