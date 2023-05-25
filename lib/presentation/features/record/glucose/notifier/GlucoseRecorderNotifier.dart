import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/models/BpRecorderModel.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/models/GlucoseRecorderModel.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';

// 사용자가 입력한 혈당 상태, 값, 푸시알림, 메모
final glucoseRecorderProvider =
    StateNotifierProvider<GlucoseRecorderNotifier, GlucoseRecorderModel>(
  (_) => GlucoseRecorderNotifier(),
);

class GlucoseRecorderNotifier extends StateNotifier<GlucoseRecorderModel> {
  GlucoseRecorderNotifier()
      : super(GlucoseRecorderModel(
          time: DateTime.now(),
          measureType: GlucoseMeasureType.None,
          glucose: 0,
        ));

  void updateTime(DateTime time) {
    state = GlucoseRecorderModel(
        time: time,
        measureType: state.measureType,
        glucose: state.glucose,
        memo: state.memo,
        remindTime: state.remindTime);
    debugPrint('update Time: ${state.time}');
  }

  void updateMeasureType(GlucoseMeasureType type) {
    state = GlucoseRecorderModel(
        time: state.time,
        measureType: type,
        glucose: state.glucose,
        memo: state.memo,
        remindTime: state.remindTime);
    debugPrint('update measureType: ${state.measureType}');
  }

  void updateGlucose(int glucose) {
    state = GlucoseRecorderModel(
        time: state.time,
        measureType: state.measureType,
        glucose: glucose,
        memo: state.memo,
        remindTime: state.remindTime);
    debugPrint('update glucose: ${state.glucose}');
  }

  void updateMemo(String memo) {
    state = GlucoseRecorderModel(
        time: state.time,
        measureType: state.measureType,
        glucose: state.glucose,
        memo: memo,
        remindTime: state.remindTime);
    debugPrint('update memo: ${state.memo}');
  }

  void updateRemindTime(int time) {
    var parseTime = time;
    if (time == 1){ // 1시간 => 60분
      parseTime = 60;
    }else if (time == 2){ // 2시간 => 120분
      parseTime = 120;
    }

    state = GlucoseRecorderModel(
        time: state.time,
        measureType: state.measureType,
        glucose: state.glucose,
        memo: state.memo,
        remindTime: parseTime);
    debugPrint('update remindTime: ${state.remindTime}');
  }

  int checkGlucoseLevel() {
    final GlucoseMeasureType type = state.measureType;
    final int glucose = state.glucose;

    if (type == GlucoseMeasureType.None || glucose == 0) {
      return 0;
    }

    switch(type){
      case GlucoseMeasureType.Fasting:
      case GlucoseMeasureType.BeforeMeal:
        if (glucose <= 99) {
          return 1;
        } else if (glucose <= 125) {
          return 2;
        } else {
          return 3;
        }
      case GlucoseMeasureType.AfterMeals:
        if (glucose <= 140) {
          return 1;
        } else if (glucose < 200) {
          return 2;
        } else {
          return 3;
        }
      default:
        return 0;
    }
  }

  RecordRangeStatus checkGlucoseStatus() {
    final GlucoseMeasureType type = state.measureType;
    final int glucose = state.glucose;

    if (type == GlucoseMeasureType.None || glucose == 0) {
      return RecordRangeStatus.None;
    }

    switch(type){
      case GlucoseMeasureType.Fasting:
      case GlucoseMeasureType.BeforeMeal:
        if (glucose <= 99) {
          return RecordRangeStatus.Normal;
        } else if (glucose <= 125) {
          return RecordRangeStatus.Warning;
        } else {
          return RecordRangeStatus.Danger;
        }
      case GlucoseMeasureType.AfterMeals:
        if (glucose <= 140) {
          return RecordRangeStatus.Normal;
        } else if (glucose < 200) {
          return RecordRangeStatus.Warning;
        } else {
          return RecordRangeStatus.Danger;
        }
      default:
        return RecordRangeStatus.None;
    }
  }
}
