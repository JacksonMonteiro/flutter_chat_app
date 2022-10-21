import 'package:chat/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
        appBar: AppBar(
          title: Text('My notifications'),
        ),
        body: ListView.builder(
            itemCount: service.itemsCount,
            itemBuilder: (context, index) => ListTile(
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),
                  onTap: () => service.remove(index),
                )));
  }
}
