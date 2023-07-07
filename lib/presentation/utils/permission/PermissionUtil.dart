import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> requestNotificationPermission() async {
    late final Map<Permission, PermissionStatus> statusess;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        statusess = await [
          Permission.notification,
        ].request();
      } else {
        return Future(() => true);
      }
      return _checkAllAccept(statusess);
    } else {
      final result = await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: false,
        sound: true,
      );
      return Future(() => result ?? false);
    }
  }

  /// 전달 받은 파라미터를 모두 허용하였는지 체크
  static bool _checkAllAccept(Map<Permission, PermissionStatus> statusess) {
    var allAccepted = true;
    statusess.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccepted = false;
      }
    });
    return allAccepted;
  }
}
