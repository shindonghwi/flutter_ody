import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarFormattNotifier.dart';
import 'package:table_calendar/table_calendar.dart';

// 캘린터 포맷 프로바이더
final CalendarFormatProvider = StateNotifierProvider<CalendarFormatNotifier, CalendarFormat>(
  (_) => CalendarFormatNotifier(),
);
