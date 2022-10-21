import 'package:chat/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];
  List<ChatNotification> get items => [..._items];
  int get itemsCount => _items.length;

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // Push Notification
  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandle);
    }
  }

  void _messageHandle(RemoteMessage? message) {
    if (message == null || message.notification == null) return;

    add(ChatNotification(
      title: message.notification?.title ?? 'Não Informado',
      body: message.notification?.body ?? 'Não informado',
    ));
  }

  Future<void> _backgroundMessageHandle(RemoteMessage message) async {
    if (message == null || message.notification == null) return;

    add(ChatNotification(
      title: message.notification?.title ?? 'Não Informado',
      body: message.notification?.body ?? 'Não informado',
    ));
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandle);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandle(initialMessage);
    }
  }
}
