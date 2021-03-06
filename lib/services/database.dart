import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getuserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatroomId, messageMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) => print(e.toString()));
  }

  getConversationMessages(String chatroomId) {
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatroomId)
        .collection("chats")
        .snapshots();
  }
}
