import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ody_flutter_app/presentation/utils/notifications/NotificationsUtil.dart';

class FirebaseCloudMessage {
  static FirebaseMessaging? fbMsg;

  static initFCM() async {
    fbMsg = FirebaseMessaging.instance;

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: false,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(
      fbMsgBackgroundHandler,
    );
    FirebaseMessaging.onMessage.listen((message) {
      fbMsgForegroundHandler(message);
    });
  }

  /// Firebase 디바이스 토큰 받아오기
  static Future<String?> getToken() async {
    String? token = await fbMsg?.getToken();
    debugPrint("device token: $token");
    return token;
  }

  static Future<void> fbMsgBackgroundHandler(RemoteMessage message) async {
    debugPrint('[FCM - Background] MESSAGE : ${message.notification?.title} ${message.notification?.body.toString()}');
    if (message.notification != null) {
      registerMessage(message);
    }
  }

  /// Firebase Foreground Messaging 핸들러
  static Future<void> fbMsgForegroundHandler(RemoteMessage message) async {
    debugPrint(
        '[FCM - Foreground] MESSAGE : ${message.notification} ${message.notification?.title} ${message.notification?.body.toString()}');
    if (message.notification != null) {
      registerMessage(message);
    }
  }

  static void registerMessage(RemoteMessage message) {
    if (message.notification != null) {
      FlutterLocalNotificationsPlugin().show(
        message.hashCode,
        NotificationsUtil.getNotificationChannel(NotificationType.REPORT),
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            NotificationsUtil.getNotificationChannel(NotificationType.REPORT).hashCode.toString(),
            NotificationsUtil.getNotificationChannel(NotificationType.REPORT),
            channelDescription: NotificationsUtil.getNotificationChannel(NotificationType.REPORT),
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            subtitle: message.notification?.body,
            sound: 'slow_spring_board.aiff',
          ),
        ),
      );
    }
  }
}
