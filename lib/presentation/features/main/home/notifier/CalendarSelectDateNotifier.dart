import 'package:hooks_riverpod/hooks_riverpod.dart';

// 사용자가 선택한 날짜
final calendarSelectDateProvider =
    StateNotifierProvider<CalendarSelectDateNotifier, DateTime>(
  (_) => CalendarSelectDateNotifier(),
);

class CalendarSelectDateNotifier extends StateNotifier<DateTime> {
  CalendarSelectDateNotifier() : super(DateTime.now());

  void updateSelectedDatetime(DateTime date) => state = date;
}
