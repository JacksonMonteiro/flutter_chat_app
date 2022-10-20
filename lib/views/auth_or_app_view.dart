import 'package:chat/models/chat_user.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/auth/auth_service_mock.dart';
import 'package:chat/views/auth_view.dart';
import 'package:chat/views/chat_view.dart';
import 'package:chat/views/loading_view.dart';
import 'package:flutter/material.dart';

class AuthOrAppView extends StatelessWidget {
  const AuthOrAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
          stream: AuthService().userChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingView();
            } else {
              return snapshot.hasData ? ChatView() : AuthView();
            }
          }),
    );
  }
}
