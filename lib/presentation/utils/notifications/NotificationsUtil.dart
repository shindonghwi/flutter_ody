import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ody_flutter_app/firebase/FirebaseCloudMessage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsUtil {
  static void init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  }

  static tz.TZDateTime getTzNow() {
    return tz.TZDateTime.now(tz.local);
  }

  /// 알림 반복 등록
  static void registerNotification({
    required NotificationType type,
    required List<Day> scheduledDays,
    required int notificationId,
    required int hour,
    required int minutes,
    required message,
  }) async {
    final channelId = getNotificationChannel(type).hashCode.toString();
    final channelName = getNotificationChannel(type);

    final android = AndroidNotificationDetails(
      getNotificationChannel(type).hashCode.toString(),
      getNotificationChannel(type),
      channelDescription: getNotificationChannel(type),
      importance: Importance.max,
      priority: Priority.high,
      ongoing: false,
      styleInformation: BigTextStyleInformation(message),
    );

    const ios = DarwinNotificationDetails(
      badgeNumber: 1,
      presentSound: true,
    );

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            AndroidNotificationChannel(
              channelId,
              channelName,
              importance: Importance.max,
            ),
          );
    }

    for (Day day in scheduledDays) {
      debugPrint("Currently processing day: ${day.toString()}");
      flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId + day.value + message.hashCode,
        _getNotificationTitle(type),
        message,
        _nextInstanceOfDay(day, hour, minutes),
        NotificationDetails(
          android: android,
          iOS: ios,
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
      debugPrint("Notification registered for: ${_nextInstanceOfDay(day, hour, minutes)} "
          "id: ${notificationId} "
          "${day.value} "
          "${message.hashCode} $message"
          "${notificationId + day.value + message.hashCode}");
    }
  }

  static tz.TZDateTime _nextInstanceOfDay(Day day, int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfWeekDay(day, hour, minute);

    tz.TZDateTime nextDateTime =
        tz.TZDateTime(tz.local, scheduledDate.year, scheduledDate.month, scheduledDate.day, hour, minute);
    debugPrint("Next datetime for day $day is: $nextDateTime");
    return nextDateTime;
  }

  // Function to find the next instance of a particular weekday
  static tz.TZDateTime _nextInstanceOfWeekDay(Day day, int hour, int minute) {
    final tz.TZDateTime now = getTzNow();
    Map<int, int> dayMap = {1: 7, 2: 1, 3: 2, 4: 3, 5: 4, 6: 5, 7: 6};
    int weekDay = dayMap[day.value]!;
    int daysInFuture = weekDay - now.weekday;

    if (daysInFuture < 0 || (daysInFuture == 0 && (now.hour > hour || (now.hour == hour && now.minute >= minute)))) {
      daysInFuture += 7;
    }

    tz.TZDateTime nextDate = now.add(Duration(days: daysInFuture));
    debugPrint("Next date for day $day is: $nextDate");
    return nextDate;
  }

  /// 오늘만 알림 등록
  static void registerOnlyTodayNotification({
    required NotificationType type,
    required int notificationId,
    required int hour,
    required int minutes,
    required message,
  }) async {
    final channelId = getNotificationChannel(type).hashCode.toString();
    final channelName = getNotificationChannel(type);

    final android = AndroidNotificationDetails(
      getNotificationChannel(type).hashCode.toString(),
      getNotificationChannel(type),
      channelDescription: getNotificationChannel(type),
      importance: Importance.max,
      priority: Priority.high,
      ongoing: false,
      styleInformation: BigTextStyleInformation(message),
    );

    const ios = DarwinNotificationDetails(
      badgeNumber: 1,
      presentSound: true,
    );

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            AndroidNotificationChannel(
              channelId,
              channelName,
              importance: Importance.max,
            ),
          );
    }

    final now = NotificationsUtil.getTzNow();
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    debugPrint("registerOnlyTodayNotification: $message $notificationId $hour, $minutes ${scheduledDate}");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      _getNotificationTitle(type),
      message,
      scheduledDate,
      NotificationDetails(
        android: android,
        iOS: ios,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: "$hour:$minutes".toString(),
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static String _getNotificationTitle(NotificationType type) {
    switch (type) {
      case NotificationType.MEDICATION:
        return "약 알림";
      case NotificationType.REPORT:
        return "보고서 알림";
      case NotificationType.GLUCOSE_REMIND:
        return "혈당 알림";
    }
  }

  static String getNotificationChannel(NotificationType type) {
    switch (type) {
      case NotificationType.MEDICATION:
        return "약 알림";
      case NotificationType.REPORT:
        return "보고서 알림";
      case NotificationType.GLUCOSE_REMIND:
        return "혈당 알림";
    }
  }

  static void removeNotification(int notificationId, Day? day, String message) {
    if (day != null) {
      debugPrint("removeNotification "
          "id: $notificationId "
          "${day.value} "
          "${message.hashCode} $message "
          "${notificationId + day.value + message.hashCode}");
      flutterLocalNotificationsPlugin.cancel(notificationId + day.value + message.hashCode);
    }
  }

  static void removeAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}

enum NotificationType { MEDICATION, REPORT, GLUCOSE_REMIND }
