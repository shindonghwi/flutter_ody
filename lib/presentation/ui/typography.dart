import 'package:flutter/material.dart';

/**
 * @feature: TextStyle 을 정의한 파일
 *
 * @author: 2023/02/07 5:49 PM donghwishin
 *
 * @description{
 *    color, underline 등 기능은 사용할때 custom 하여 사용한다.
 * }
 */
const defaultTextStyle = TextStyle(
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.w100,
  overflow: TextOverflow.ellipsis,
  letterSpacing: 0,
);

extension StyleText on TextTheme {
  TextStyle get h1 => defaultTextStyle.copyWith(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      height: 1.17
  );
  TextStyle get h2 => defaultTextStyle.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.25
  );
  TextStyle get h3 => defaultTextStyle.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.28
  );
  TextStyle get h4 => defaultTextStyle.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.33
  );
  TextStyle get t1 => defaultTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 1.27
  );
  TextStyle get t1b => defaultTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.27
  );
  TextStyle get t2 => defaultTextStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.4
  );
  TextStyle get t3 => defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.33
  );
  TextStyle get t3b => defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.33
  );
  TextStyle get t4 => defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5
  );
  TextStyle get l1 => defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.33
  );
  TextStyle get l1b => defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.33
  );
  TextStyle get l2 => defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5
  );
  TextStyle get l3 => defaultTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.42
  );
  TextStyle get b1 => defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.33
  );
  TextStyle get b2 => defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5
  );
  TextStyle get b3 => defaultTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.42
  );
  TextStyle get c1 => defaultTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.42
  );
  TextStyle get c1b => defaultTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 1.42
  );
  TextStyle get c2 => defaultTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33
  );
  TextStyle get c3 => defaultTextStyle.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.6
  );
}
