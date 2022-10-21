import 'package:chat/firebase_options.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/auth/auth_service_mock.dart';
import 'package:chat/services/notification/chat_notification_service.dart';
import 'package:chat/views/auth_view.dart';
import 'package:chat/views/chat_view.dart';
import 'package:chat/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class AuthOrAppView extends StatelessWidget {
  const AuthOrAppView({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Provider.of<ChatNotificationService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingView();
        } else {
          return StreamBuilder<ChatUser?>(
              stream: AuthService().userChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingView();
                } else {
                  return snapshot.hasData ? ChatView() : AuthView();
                }
              });
        }
      },
    );
  }
}
