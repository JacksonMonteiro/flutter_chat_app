import 'package:chat/models/chat_user.dart';
import 'dart:io';

import 'package:chat/services/auth/auth_service.dart';

class AuthServiceMock implements AuthService {
  @override
  ChatUser? get currentUser => null;

  @override
  Future<void> login(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError();
  }

  @override
  Future<void> signup(
      String name, String email, String password, File image) async {
    throw UnimplementedError();
  }

  @override
  Stream<ChatUser?> get userChanges => throw UnimplementedError();
}
