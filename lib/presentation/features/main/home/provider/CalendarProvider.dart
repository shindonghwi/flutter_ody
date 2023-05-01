import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/DimNotifier.dart';

// 사용자가 선택한 날짜. 기본 - 오늘날짜
final CalendarProvider = StateNotifierProvider<CalendarNotifier, DateTime>(
  (_) => CalendarNotifier(),
);
