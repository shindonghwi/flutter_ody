import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarNotifier extends StateNotifier<DateTime> {
  CalendarNotifier() : super(DateTime.now());

  void updateCurrentDate(DateTime date) => state = date;
}
