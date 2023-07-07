import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';

// 캘린터 높이 프로바이더
final calendarHeightProvider = StateNotifierProvider<CalendarHeightNotifier, double>(
      (_) {
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    return CalendarHeightNotifier(CalendarSize.minHeight(context));
  },
);


class CalendarHeightNotifier extends StateNotifier<double> {
  final double initHeight;

  CalendarHeightNotifier(this.initHeight) : super(initHeight);

  void updateHeight(double height) => state = height;

  double getHeight() => state;
}
