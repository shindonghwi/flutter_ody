import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class ButtonSize {
  static const double _normalHeight = 60;
  static const double _normalPaddingVertical = 18;
  static const double _normalPaddingHorizontal = 25;

  static const double _smallHeight = 50;
  static const double _smallPaddingVertical = 13;
  static const double _smallPaddingHorizontal = 25;

  /** 타입에 따른 버튼 패딩 반환 */
  static EdgeInsets getButtonPadding(ButtonSizeType type) {
    final Pair padding;

    switch (type) {
      case ButtonSizeType.Normal:
        padding = ButtonSize._getNormalPadding();
        break;
      case ButtonSizeType.Small:
        padding = ButtonSize._getSmallPadding();
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
        ButtonSize._normalPaddingVertical,
        ButtonSize._normalPaddingHorizontal,
      );

  static _getSmallPadding() => Pair(
        ButtonSize._smallPaddingVertical,
        ButtonSize._smallPaddingHorizontal,
      );
}
