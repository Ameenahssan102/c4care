import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> initNotification() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    await messaging.requestPermission(provisional: true);
  }
}
