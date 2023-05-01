import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarPageNotifier extends StateNotifier<DateTime> {
  CalendarPageNotifier() : super(DateTime.now());

  void updatePageDatetime(DateTime date) => state = date;
}
