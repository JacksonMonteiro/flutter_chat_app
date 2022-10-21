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
    final message = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(message);

    final docSnapshot = await docRef.get();
    return docSnapshot.data();
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
