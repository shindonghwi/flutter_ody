import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseTypeModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';
import 'package:ody_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/models/GlucoseRecorderModel.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';

// 사용자가 입력한 혈당 상태, 값, 푸시알림, 메모
final glucoseRecorderProvider = StateNotifierProvider<GlucoseRecorderNotifier, GlucoseRecorderModel>(
  (_) => GlucoseRecorderNotifier(),
);

class GlucoseRecorderNotifier extends StateNotifier<GlucoseRecorderModel> {
  GlucoseRecorderNotifier()
      : super(GlucoseRecorderModel(
          time: DateTime.now(),
          measureType: GlucoseMeasureType.None,
          glucose: 0,
        ));

  var glucoseStatus = RecordRangeStatus.None;

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
        time: state.time, measureType: type, glucose: state.glucose, memo: state.memo, remindTime: state.remindTime);
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
    if (time == 1) {
      // 1시간 => 60분
      parseTime = 60;
    } else if (time == 2) {
      // 2시간 => 120분
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

  ResponseBioGlucoseModel getBioGlucoseModel() {
    return ResponseBioGlucoseModel(
      type: ResponseBioGlucoseTypeModel(
        code: state.measureType.name.toString(),
        name: GlucoseMeasureTypeHelper.fromString(state.measureType),
      ),
      glucose: state.glucose,
      status: ResponseBioStatusModel(
        code: glucoseStatus.name.toString(),
        name: RecordRangeStatusHelper.fromString(glucoseStatus),
      ),
      createdAt: "${DateTime.now().hour}:${DateTime.now().minute}",
    );
  }

  /**
   *   1. 당뇨병 환자의 혈당 기준
      - 공복 혈당: 126mg/dL 이상
      - 식후 2시간 경과 혈당: 200mg/dL 이상
      - 당화혈색소(HbA1c): 6.5% 이상

      2. 정상인의 혈당 기준
      - 공복 혈당: 100mg/dL 이하
      - 식후 2시간 경과 혈당: 140mg/dL 이하
      - 당화혈색소(HbA1c): 5.6% 이하

      3. 공복 혈당과 식사 전후의 혈당 변화 기준
      - 공복 혈당: 100mg/dL 이하
      - 식사 전 혈당: 100-140mg/dL
      - 식사 후 1시간 경과 혈당: 100-160mg/dL
      - 식사 후 2시간 경과 혈당: 100-140mg/dL

      4. 운동 후 혈당 변화 기준
      - 운동 후 30분 경과 혈당: 100-140mg/dL
      - 운동 후 1시간 경과 혈당: 100-180mg/dL
      - 운동 후 2시간 경과 혈당: 100-140mg/dL
   * */

  int checkGlucoseLevel() {
    final GlucoseMeasureType type = state.measureType;
    final int glucose = state.glucose;

    if (type == GlucoseMeasureType.None || glucose == 0) {
      return 0;
    }

    switch (type) {
      // 공복
      case GlucoseMeasureType.Fasting:
        if (glucose <= 100) {
          return 1;
        } else if (glucose <= 126) {
          return 2;
        } else {
          return 3;
        }
      // 식사전
      case GlucoseMeasureType.Preprandial:
        if (glucose <= 100) {
          return 1;
        } else if (glucose <= 140) {
          return 2;
        } else {
          return 3;
        }
      // 식사전
      case GlucoseMeasureType.Postprandial:
        if (glucose <= 140) {
          return 1;
        } else if (glucose <= 200) {
          return 2;
        } else {
          return 3;
        }
      // 식사전
      case GlucoseMeasureType.PostExercise:
        if (glucose <= 140) {
          return 1;
        } else if (glucose <= 180) {
          return 2;
        } else {
          return 3;
        }
      default:
        {
          return 0;
        }
    }
  }

  RecordRangeStatus checkGlucoseStatus() {
    final GlucoseMeasureType type = state.measureType;
    final int glucose = state.glucose;

    if (type == GlucoseMeasureType.None || glucose == 0) {
      return RecordRangeStatus.None;
    }

    switch (type) {
      // 공복
      case GlucoseMeasureType.Fasting:
        if (glucose <= 100) {
          glucoseStatus = RecordRangeStatus.Normal;
        } else if (glucose <= 126) {
          glucoseStatus = RecordRangeStatus.Danger;
        } else {
          glucoseStatus = RecordRangeStatus.Risk;
        }
        break;
      case GlucoseMeasureType.Preprandial:
        if (glucose <= 100) {
          glucoseStatus = RecordRangeStatus.Normal;
        } else if (glucose <= 140) {
          glucoseStatus = RecordRangeStatus.Danger;
        } else {
          glucoseStatus = RecordRangeStatus.Risk;
        }
        break;
    // 식사전
      case GlucoseMeasureType.Postprandial:
        if (glucose <= 140) {
          glucoseStatus = RecordRangeStatus.Normal;
        } else if (glucose <= 200) {
          glucoseStatus = RecordRangeStatus.Danger;
        } else {
          glucoseStatus = RecordRangeStatus.Risk;
        }
        break;
    // 식사전
      case GlucoseMeasureType.PostExercise:
        if (glucose <= 140) {
          glucoseStatus = RecordRangeStatus.Normal;
        } else if (glucose <= 180) {
          glucoseStatus = RecordRangeStatus.Danger;
        } else {
          glucoseStatus = RecordRangeStatus.Risk;
        }
        break;
      default:
        {
          glucoseStatus = RecordRangeStatus.None;
        }
    }

    return glucoseStatus;
  }

  void init() {
    state = GlucoseRecorderModel(
      time: DateTime.now(),
      measureType: GlucoseMeasureType.None,
      glucose: 0,
    );
  }
}
