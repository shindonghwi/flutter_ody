import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';

class OutlineButtonSize {
  static const double _largeHeight = 60;

  static const double _normalHeight = 50;

  static const double _smallHeight = 40;

  static const double _xsmallHeight = 30;


  /// 타입에 따른 버튼 높이 반환
  static double getButtonHeight(ButtonSizeType type) {
    switch (type) {
      case ButtonSizeType.Large:
        return _largeHeight;
      case ButtonSizeType.Normal:
        return _normalHeight;
      case ButtonSizeType.Small:
        return _smallHeight;
      case ButtonSizeType.XSmall:
        return _xsmallHeight;
    }
  }
}
