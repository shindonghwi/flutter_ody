import 'package:riverpod/riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 캘린터 포맷 프로바이더
final calendarFormatProvider =
    StateNotifierProvider<CalendarFormatNotifier, CalendarFormat>(
  (_) => CalendarFormatNotifier(),
);

class CalendarFormatNotifier extends StateNotifier<CalendarFormat> {
  CalendarFormatNotifier() : super(CalendarFormat.week);

  void updateFormat(CalendarFormat format) => state = format;
}
