import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';

// 사용자가 선택한 날짜
final CalendarSelectDateProvider = StateNotifierProvider<CalendarSelectDateNotifier, DateTime>(
  (_) => CalendarSelectDateNotifier(),
);
