import 'package:intl/intl.dart';

class DateTransfer {
  static String dateTimeToAmPmTime(DateTime time){
    var formatter = DateFormat('a h시 mm분', 'ko_KR');
    return formatter.format(time);
  }
  static String dateTimeToYearMonthDay(DateTime time){
    var formatter = DateFormat('yyyy / MM / dd', 'ko_KR');
    return formatter.format(time);
  }
}
