import 'package:hooks_riverpod/hooks_riverpod.dart';

// 캘린터 페이지 업데이트 프로바이더
final calendarPageProvider = StateNotifierProvider<CalendarPageNotifier, DateTime>(
  (_) => CalendarPageNotifier(),
);

class CalendarPageNotifier extends StateNotifier<DateTime> {
  CalendarPageNotifier() : super(DateTime.now());

  void updatePageDatetime(DateTime date) => state = date;

  DateTime getCurrentDateTime() => state;

}
