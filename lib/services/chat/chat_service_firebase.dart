import 'dart:async';

import 'package:chat/models/chat_user.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    // Turn a ChatMessage into a Map<String, dynamic>
    final docRef = await store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.imageURL
    });

    final docSnapshot = await docRef.get();
    final data = docSnapshot.data();

    // Turn a Map<String, dynamic> Into a ChatMessage
    return ChatMessage(
      id: docSnapshot.id,
      text: data?['text'],
      createdAt: DateTime.parse(data?['createdAt']),
      userId: data?['userId'],
      userName: data?['userName'],
      userImageURL: data?['userImageURL'],
    );
  }

  ChatMessage _fromFirestore(DocumentSnapshot<Map<String, dynamic>> docSnapshot,
      SnapshotOptions? options) {
    return ChatMessage(
      id: docSnapshot.id,
      text: docSnapshot['text'],
      createdAt: DateTime.parse(docSnapshot['createdAt']),
      userId: docSnapshot['userId'],
      userName: docSnapshot['userName'],
      userImageURL: docSnapshot['userImageURL'],
    );
  }

  Map<String, dynamic> _toFirestore(ChatMessage message, SetOptions? options) {
    return {
      'text': message.text,
      'createdAt': message.createdAt.toIso8601String(),
      'userId': message.userId,
      'userName': message.userName,
      'userImageURL': message.userImageURL,
    };
  }
}
