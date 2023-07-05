import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsUtil {
  static void init() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  }

  static tz.TZDateTime getTzNow() {
    return tz.TZDateTime.now(tz.local);
  }

  static void registerNotification({
    required NotificationType type,
    required List<Day> scheduledDays,
    required int notificationId,
    required int hour,
    required int minutes,
    required message,
  }) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    for (Day day in scheduledDays) {
      debugPrint("registerNotification: $message $notificationId $day, $hour, $minutes");
      tz.TZDateTime scheduledDate = _getNextScheduledDate(day, hour, minutes);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        _getNotificationTitle(type),
        message,
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _getNotificationChannel(type).hashCode.toString(),
            _getNotificationChannel(type),
            importance: Importance.max,
            priority: Priority.high,
            ongoing: false,
            styleInformation: BigTextStyleInformation(message),
          ),
          iOS: const DarwinNotificationDetails(
            badgeNumber: 1,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: day.toString(),
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  static tz.TZDateTime _getNextScheduledDate(Day day, int hour, int minute) {
    debugPrint("day: ${day.value}");

    final now = NotificationsUtil.getTzNow();
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    int currentWeekday = now.weekday % 7; // Adjust to match the Day enum numbering scheme
    int targetWeekday = (day.value + 6) % 7; // Adjust to match the Day enum numbering scheme
    int daysToAdd = (targetWeekday - currentWeekday + 7) % 7;
    if (daysToAdd <= 0 || (daysToAdd == 0 && scheduledDate.isBefore(now))) {
      daysToAdd += 7;
    }
    scheduledDate = scheduledDate.add(Duration(days: daysToAdd));

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7)); // Add 7 days to schedule for the next week
    }

    if (scheduledDate.month < now.month) {
      scheduledDate = scheduledDate.add(const Duration(days: 365)); // Add 365 days to schedule for the next year
    }

    debugPrint("scheduledDate: ${scheduledDate.year} ${scheduledDate.month} ${scheduledDate.day} ${scheduledDate.weekday}");

    return scheduledDate;
  }

  static String _getNotificationTitle(NotificationType type) {
    switch (type) {
      case NotificationType.ALARM:
        return "약 알림";
      case NotificationType.REPORT:
        return "보고서 알림";
    }
  }

  static String _getNotificationChannel(NotificationType type) {
    switch (type) {
      case NotificationType.ALARM:
        return "약 알림";
      case NotificationType.REPORT:
        return "보고서 알림";
    }
  }

  static void removeNotification(int notificationId) {
    debugPrint("removeNotification: $notificationId");
    FlutterLocalNotificationsPlugin().cancel(notificationId);
  }
}

enum NotificationType { ALARM, REPORT }
