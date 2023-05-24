import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/models/BpRecorderModel.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';

// 사용자가 입력한 수축기, 이완기 혈압, 맥박
final bloodPressureRecorderProvider =
    StateNotifierProvider<BloodPressureRecorderNotifier, BpRecorderModel>(
  (_) => BloodPressureRecorderNotifier(),
);

class BloodPressureRecorderNotifier extends StateNotifier<BpRecorderModel> {
  final yearMonthDay = DateTime.now().toString().split(" ")[0].split("-");
  final hourMinuteSecond = DateTime.now().toString().split(" ")[1].split(":");

  BloodPressureRecorderNotifier()
      : super(BpRecorderModel(
            time: DateTime.now(),
            systolic: 0,
            diastolic: 0,
            hr: 0));

  void updateTime(DateTime time) {
    state = BpRecorderModel(
        time: time,
        systolic: state.systolic,
        diastolic: state.diastolic,
        hr: state.hr);
  }

  void updateSystolicBloodPressure(int systolicBloodPressure) {
    state = BpRecorderModel(
        time: state.time,
        systolic: systolicBloodPressure,
        diastolic: state.diastolic,
        hr: state.hr);
  }

  void updateDiastolicBloodPressure(int diastolicBloodPressure) {
    state = BpRecorderModel(
        time: state.time,
        systolic: state.systolic,
        diastolic: diastolicBloodPressure,
        hr: state.hr);
  }

  void updateHeartRate(int heartRate) {
    state = BpRecorderModel(
        time: state.time,
        systolic: state.systolic,
        diastolic: state.diastolic,
        hr: heartRate);
  }

  int checkBpLevel() {
    final int systolic = state.systolic;
    final int diastolic = state.diastolic;

    if (systolic == 0 || diastolic == 0) {
      return 0;
    }

    if (systolic <= 90 || diastolic <= 60) {
      return 1;
    } else if (systolic <= 120 || diastolic <= 80) {
      return 2;
    } else if (systolic <= 140 || diastolic <= 90) {
      return 3;
    } else if (systolic <= 160 || diastolic <= 100) {
      return 4;
    } else {
      return 5;
    }
  }

  RecordRangeStatus checkBpStatus() {
    final int systolic = state.systolic;
    final int diastolic = state.diastolic;

    if (systolic == 0 || diastolic == 0) {
      return RecordRangeStatus.None;
    }

    if (systolic <= 90 || diastolic <= 60) {
      return RecordRangeStatus.LowBp;
    } else if (systolic <= 120 || diastolic <= 80) {
      return RecordRangeStatus.Normal;
    } else if (systolic <= 140 || diastolic <= 90) {
      return RecordRangeStatus.HighBp;
    } else if (systolic <= 160 || diastolic <= 100) {
      return RecordRangeStatus.HighBp;
    } else {
      return RecordRangeStatus.HighBp;
    }
  }
}
