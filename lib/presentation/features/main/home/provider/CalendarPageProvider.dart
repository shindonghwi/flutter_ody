import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/DimNotifier.dart';

// 캘린터 페이지 업데이트 프로바이더
final CalendarPageProvider = StateNotifierProvider<CalendarPageNotifier, DateTime>(
  (_) => CalendarPageNotifier(),
);
