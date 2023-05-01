import 'package:riverpod/riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarFormatNotifier extends StateNotifier<CalendarFormat> {
  CalendarFormatNotifier() : super(CalendarFormat.week);

  void updateFormat(CalendarFormat format) => state = format;
}
