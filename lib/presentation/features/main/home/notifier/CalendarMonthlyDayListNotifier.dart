import 'package:hooks_riverpod/hooks_riverpod.dart';


final calendarMonthlyDayListProvider = StateNotifierProvider<CalendarMonthlyDayListNotifier, List<String>>(
  (_) => CalendarMonthlyDayListNotifier(),
);

class CalendarMonthlyDayListNotifier extends StateNotifier<List<String>> {
  CalendarMonthlyDayListNotifier() : super([]);

  void updateDayList(List<String> days) => state = days;
}
