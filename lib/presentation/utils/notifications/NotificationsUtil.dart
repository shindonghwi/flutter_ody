import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsUtil {

  static tz.TZDateTime getTzNow(){
    return tz.TZDateTime.now(tz.local);
  }

  static Future<void> registerMessage({
    required int hour,
    required int minutes,
    required message,
  }) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      6,
      'flutter_local_notifications',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
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
      matchDateTimeComponents: DateTimeComponents.time,
    );

    Future.delayed(Duration(seconds: 5), () async {
      await flutterLocalNotificationsPlugin.cancel(6);
    });
  }
}
