import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/app/OrotApp.dart';
import 'package:odac_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarHeightNotifier.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

// 캘린터 높이 프로바이더
final CalendarHeightProvider = StateNotifierProvider<CalendarHeightNotifier, double>(
  (_) {
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    return CalendarHeightNotifier(CalendarSize.minHeight(context));
  },
);
