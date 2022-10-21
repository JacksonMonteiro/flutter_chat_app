import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My notifications'),
      ),
      body: Center(
        child: Text('Notifications'),
      ),
    );
  }
}
