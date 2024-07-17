import 'package:C4CARE/Values/dialogs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingService {
  final BuildContext context;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  MessagingService({required this.context});

  Future<void> init() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Dialogs.showAlertDialog3(
          context: context,
          title: message.notification?.title ?? "",
          subTitle: message.notification?.body ?? "",
          yesClick: () {});
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Dialogs.showAlertDialog3(
          context: context,
          title: message.notification?.title ?? "",
          subTitle: message.notification?.body ?? "",
          yesClick: () => {});
    });
  }
}
