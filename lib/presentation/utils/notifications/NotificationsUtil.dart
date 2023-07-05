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
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  static tz.TZDateTime _getNextScheduledDate(Day day, int hour, int minute) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduledDate.weekday != day.value) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

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
    FlutterLocalNotificationsPlugin().cancel(notificationId);
  }
}

enum NotificationType { ALARM, REPORT }
