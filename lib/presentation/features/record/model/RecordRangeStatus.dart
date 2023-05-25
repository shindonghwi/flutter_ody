import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

enum RecordRangeStatus {
  LowBp, // 저혈압
  HighBp, // 고혈압
  Warning, // 주의
  Normal, // 정상
  Danger, // 위험
  None, // --
}

class RecordRangeStatusHelper {
  static const Map<RecordRangeStatus, String> _stringToEnum = {
    RecordRangeStatus.LowBp: "저혈압",
    RecordRangeStatus.HighBp: "고혈압",
    RecordRangeStatus.Normal: "정상",
    RecordRangeStatus.Warning: "주의",
    RecordRangeStatus.Danger: "위험",
    RecordRangeStatus.None: "정상"
  };

  static String fromString(RecordRangeStatus status) => _stringToEnum[status] ?? "정상";

  static Color getStatusColor(
    BuildContext context,
    RecordRangeStatus status,
  ) {
    switch (status) {
      case RecordRangeStatus.Normal:
        return getColorScheme(context).primary100;
      case RecordRangeStatus.LowBp:
      case RecordRangeStatus.HighBp:
      case RecordRangeStatus.Danger:
        return getColorScheme(context).error100;
      default:
        return getColorScheme(context).neutral50;
    }
  }

  static Color getSubTextColor(
    BuildContext context,
    RecordRangeStatus status,
  ) {
    if (status == RecordRangeStatus.None) {
      return getColorScheme(context).neutral50;
    } else {
      return getColorScheme(context).colorText;
    }
  }

  static List<Color> getDividerColorList(
    BuildContext context,
    RecordType type,
    RecordRangeStatus status,
  ) {
    if (type == RecordType.BloodPressure) {
      switch (status) {
        case RecordRangeStatus.Normal:
          return [
            getColorScheme(context).primary20,
            getColorScheme(context).primary40,
            getColorScheme(context).primary60,
            getColorScheme(context).primary80,
            getColorScheme(context).primary100,
          ];
        case RecordRangeStatus.LowBp:
        case RecordRangeStatus.HighBp:
        case RecordRangeStatus.Danger:
          return [
            getColorScheme(context).error20,
            getColorScheme(context).error40,
            getColorScheme(context).error60,
            getColorScheme(context).error80,
            getColorScheme(context).error100,
          ];
        default:
          return [
            getColorScheme(context).neutral30,
            getColorScheme(context).neutral30,
            getColorScheme(context).neutral30,
            getColorScheme(context).neutral30,
            getColorScheme(context).neutral30,
          ];
      }
    }else if (type == RecordType.Glucose){
      if (status == RecordRangeStatus.Normal){
        return [
          getColorScheme(context).primary20,
          getColorScheme(context).primary40,
          getColorScheme(context).primary80,
        ];
      }else if (status == RecordRangeStatus.Warning){
        return [
          getColorScheme(context).error20,
          getColorScheme(context).error40,
          getColorScheme(context).error80,
        ];
      }else if (status == RecordRangeStatus.Danger){
        return [
          getColorScheme(context).error20,
          getColorScheme(context).error40,
          getColorScheme(context).error80,
        ];
      }
    }
    return [
      getColorScheme(context).neutral30,
      getColorScheme(context).neutral30,
      getColorScheme(context).neutral30,
    ];
  }

  static String getOdyImagePath(
    RecordType type,
    RecordRangeStatus status,
  ) {
    if (type == RecordType.BloodPressure) {
      switch (status) {
        case RecordRangeStatus.Normal:
          return "assets/imgs/ody_bp_result_normal.png";
        case RecordRangeStatus.LowBp:
        case RecordRangeStatus.HighBp:
        case RecordRangeStatus.Danger:
          return "assets/imgs/ody_bp_result_danger.png";
        default:
          return "assets/imgs/ody_bp_result_default.png";
      }
    } else {
      switch (status) {
        case RecordRangeStatus.Normal:
          return "assets/imgs/ody_glucose_result_normal.png";
        case RecordRangeStatus.Warning:
          return "assets/imgs/ody_glucose_result_danger.png";
        default:
          return "assets/imgs/ody_glucose_result_default.png";
      }
    }
  }
}
