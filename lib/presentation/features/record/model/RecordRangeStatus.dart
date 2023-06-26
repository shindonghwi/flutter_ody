import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

enum RecordRangeStatus {
  Normal, // 정상
  Danger, // 위험
  Risk, // 고위험
  None, // --
}

class RecordRangeStatusHelper {
  static const Map<RecordRangeStatus, String> _stringToEnum = {
    RecordRangeStatus.Normal: "정상",
    RecordRangeStatus.Danger: "위험",
    RecordRangeStatus.Risk: "고위험",
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
      case RecordRangeStatus.Danger:
        return getColorScheme(context).error40;
      case RecordRangeStatus.Risk:
        return getColorScheme(context).error80;
      default:
        return getColorScheme(context).neutral30;
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
    if (status == RecordRangeStatus.Normal){
      return [
        getColorScheme(context).primary20,
        getColorScheme(context).primary40,
        getColorScheme(context).primary80,
      ];
    }else if (status == RecordRangeStatus.Danger){
      return [
        getColorScheme(context).error20,
        getColorScheme(context).error40,
        getColorScheme(context).error80,
      ];
    }else if (status == RecordRangeStatus.Risk){
      return [
        getColorScheme(context).error20,
        getColorScheme(context).error40,
        getColorScheme(context).error80,
      ];
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
        case RecordRangeStatus.Danger:
          return "assets/imgs/ody_bp_result_danger.png";
        default:
          return "assets/imgs/ody_bp_result_default.png";
      }
    } else {
      switch (status) {
        case RecordRangeStatus.Normal:
          return "assets/imgs/ody_glucose_result_normal.png";
        case RecordRangeStatus.Danger:
          return "assets/imgs/ody_glucose_result_danger.png";
        default:
          return "assets/imgs/ody_glucose_result_default.png";
      }
    }
  }
}
