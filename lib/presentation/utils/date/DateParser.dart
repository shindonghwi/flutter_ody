import 'package:intl/intl.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';

class DateParser {
  static String getGlobalTimeDate(DateTime time) {
    String formattedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(time);
    String timeZoneOffset = DateParser._getTimeZoneOffset(time);
    String timeZoneName = Service.headers["Application-Time-Zone"].toString();
    String result = "$formattedDateTime$timeZoneOffset[$timeZoneName]";
    return result;
  }

  static String _getTimeZoneOffset(DateTime time) {
    Duration offset = time.timeZoneOffset;
    String hours = offset.inHours.toString().padLeft(2, '0');
    String minutes = (offset.inMinutes % 60).toString().padLeft(2, '0');
    String sign = offset.isNegative ? "-" : "+";
    return "$sign$hours:$minutes";
  }

  static String getTimeZoneName(DateTime date) {
    String timeZoneName = '';
    List<String> timeZoneIds = getTimeZoneIds(date);
    if (timeZoneIds.isNotEmpty) {
      timeZoneName = timeZoneIds[0];
    }
    return timeZoneName;
  }

  static List<String> getTimeZoneIds(DateTime date) {
    Set<String> timeZoneIds = Set<String>();
    DateTime startDate = DateTime(date.year - 1);
    DateTime endDate = DateTime(date.year + 1);

    for (DateTime d = startDate; d.isBefore(endDate); d = d.add(Duration(days: 1))) {
      timeZoneIds.add(d.timeZoneName);
    }

    return timeZoneIds.toList();
  }

}


// 2011-12-03T10:15:30+01:00[Europe/Paris]
// 2023-05-24T18:05:30+09:00[Asia/Seoul]