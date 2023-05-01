import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarSelectDateNotifier extends StateNotifier<DateTime> {
  CalendarSelectDateNotifier() : super(DateTime.now());

  void updateSelectedDatetime(DateTime date) => state = date;
}
