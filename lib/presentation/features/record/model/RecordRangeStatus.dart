import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

enum RecordRangeStatus {
  Normal, // 정상
  Risk, // 위험
  HighRisk, // 고위험
  Warn, // 주의
  Alert, // 위험
  None, // --
}

class RecordRangeStatusHelper {
  static const Map<RecordRangeStatus, String> _stringToEnum = {
    RecordRangeStatus.Normal: "정상",
    RecordRangeStatus.Risk: "위험",
    RecordRangeStatus.HighRisk: "고위험",
    RecordRangeStatus.Warn: "주의",
    RecordRangeStatus.Alert: "위험",
    RecordRangeStatus.None: ""
  };

  static String fromString(RecordRangeStatus status) => _stringToEnum[status] ?? "";

  static Color getStatusColor(
    BuildContext context,
    RecordRangeStatus status,
  ) {
    switch (status) {
      case RecordRangeStatus.Normal:
        return getColorScheme(context).primary20;
      case RecordRangeStatus.Risk:
      case RecordRangeStatus.Warn:
        return getColorScheme(context).error40;
      case RecordRangeStatus.HighRisk:
      case RecordRangeStatus.Alert:
        return getColorScheme(context).error80;
      default:
        return getColorScheme(context).neutral30;
    }
  }

  static Color getStatusTextColor(
    BuildContext context,
    RecordRangeStatus status,
  ) {
    switch (status) {
      case RecordRangeStatus.Normal:
        return getColorScheme(context).primary100;
      case RecordRangeStatus.Risk:
      case RecordRangeStatus.Warn:
        return getColorScheme(context).error40;
      case RecordRangeStatus.HighRisk:
      case RecordRangeStatus.Alert:
        return getColorScheme(context).colorError;
      default:
        return getColorScheme(context).neutral30;
    }
  }

  static RecordRangeStatus getBPRecordRangeStatusFromCode(String code) {
    return code.toLowerCase() == RecordRangeStatus.Normal.name.toString().toLowerCase()
        ? RecordRangeStatus.Normal
        : code.toLowerCase() == RecordRangeStatus.Risk.name.toString().toLowerCase()
            ? RecordRangeStatus.Risk
            : code.toLowerCase() == RecordRangeStatus.HighRisk.name.toString().toLowerCase()
                ? RecordRangeStatus.HighRisk
                : RecordRangeStatus.None;
  }

  static RecordRangeStatus getGlucoseRecordRangeStatusFromCode(String code) {
    return code.toLowerCase() == RecordRangeStatus.Normal.name.toString().toLowerCase()
        ? RecordRangeStatus.Normal
        : code.toLowerCase() == RecordRangeStatus.Warn.name.toString().toLowerCase()
            ? RecordRangeStatus.Warn
            : code.toLowerCase() == RecordRangeStatus.Alert.name.toString().toLowerCase()
                ? RecordRangeStatus.Alert
                : RecordRangeStatus.None;
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
    RecordRangeStatus status,
  ) {
    if (status == RecordRangeStatus.None) {
      return [
        getColorScheme(context).neutral30,
        getColorScheme(context).neutral30,
        getColorScheme(context).neutral30,
      ];
    } else if (status == RecordRangeStatus.Normal) {
      return [
        getColorScheme(context).primary20,
        getColorScheme(context).primary40,
        getColorScheme(context).primary80,
      ];
    } else {
      return [
        getColorScheme(context).error20,
        getColorScheme(context).error40,
        getColorScheme(context).error80,
      ];
    }
  }

  static String getOdyImagePath(
    RecordType type,
    RecordRangeStatus status,
  ) {
    if (type == RecordType.Walk) {
      switch (status) {
        case RecordRangeStatus.None:
          return "assets/imgs/character_walking_disabled.png";
        default:
          return "assets/imgs/character_walking_active.png";
      }
    } else if (type == RecordType.BloodPressure) {
      switch (status) {
        case RecordRangeStatus.Normal:
          return "assets/imgs/character_bp_normal.png";
        case RecordRangeStatus.Risk:
          return "assets/imgs/character_bp_warning.png";
        case RecordRangeStatus.HighRisk:
          return "assets/imgs/character_bp_dangerous.png";
        default:
          return "assets/imgs/character_bp_disabled.png";
      }
    } else if (type == RecordType.Glucose) {
      switch (status) {
        case RecordRangeStatus.Normal:
          return "assets/imgs/character_bs_normal.png";
        case RecordRangeStatus.Warn:
          return "assets/imgs/character_bs_warning.png";
        case RecordRangeStatus.Alert:
          return "assets/imgs/character_bs_dangerous.png";
        default:
          return "assets/imgs/character_bs_disabled.png";
      }
    } else {
      return "assets/imgs/character_emotion_disabled.png";
    }
  }
}
