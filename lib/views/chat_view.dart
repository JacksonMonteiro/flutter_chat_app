import 'package:chat/services/auth/auth_service_mock.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CHAT'),
            TextButton(
              onPressed: () {
                AuthServiceMock().logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
