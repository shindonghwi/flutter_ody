import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class FillButtonSize {
  static const double _normalHeight = 60;
  static const double _normalPaddingVertical = 20;
  static const double _normalPaddingHorizontal = 26;

  static const double _smallHeight = 50;
  static const double _smallPaddingVertical = 15;
  static const double _smallPaddingHorizontal = 26;

  /** 타입에 따른 버튼 패딩 반환 */
  static EdgeInsets getButtonPadding(ButtonSizeType type) {
    final Pair padding;

    switch (type) {
      case ButtonSizeType.Normal:
        padding = FillButtonSize._getNormalPadding();
        break;
      case ButtonSizeType.Small:
        padding = FillButtonSize._getSmallPadding();
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
        FillButtonSize._normalPaddingVertical,
        FillButtonSize._normalPaddingHorizontal,
      );

  static _getSmallPadding() => Pair(
        FillButtonSize._smallPaddingVertical,
        FillButtonSize._smallPaddingHorizontal,
      );
}
