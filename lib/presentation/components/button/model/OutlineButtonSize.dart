import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class OutlineButtonSize {
  static const double _normalHeight = 50;
  static const double _normalPaddingVertical = 13;
  static const double _normalPaddingHorizontal = 50;

  static const double _smallHeight = 30;
  static const double _smallPaddingVertical = 6;
  static const double _smallPaddingHorizontal = 15;

  /** 타입에 따른 버튼 패딩 반환 */
  static EdgeInsets getButtonPadding(ButtonSizeType type) {
    final Pair padding;

    switch (type) {
      case ButtonSizeType.Normal:
        padding = OutlineButtonSize._getNormalPadding();
        break;
      case ButtonSizeType.Small:
        padding = OutlineButtonSize._getSmallPadding();
        break;
    }

    return EdgeInsets.symmetric(
      vertical: padding.first,
      horizontal: padding.second,
    );
  }

  /** 타입에 따른 버튼 높이 반환 */
  static double getButtonHeight(ButtonSizeType type) {
    switch (type) {
      case ButtonSizeType.Normal:
        return _normalHeight;
      case ButtonSizeType.Small:
        return _smallHeight;
    }
  }

  static _getNormalPadding() => Pair(
        OutlineButtonSize._normalPaddingVertical,
        OutlineButtonSize._normalPaddingHorizontal,
      );

  static _getSmallPadding() => Pair(
        OutlineButtonSize._smallPaddingVertical,
        OutlineButtonSize._smallPaddingHorizontal,
      );
}
