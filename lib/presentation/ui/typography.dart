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
  fontFamily: 'sc_dream',
  fontWeight: FontWeight.w500,
  overflow: TextOverflow.ellipsis,
);

// Text Theme
TextTheme odacTextTheme = TextTheme(
  displayLarge: defaultTextStyle.copyWith(
    fontSize: 57,
    height: 1.12,
  ),
  displayMedium: defaultTextStyle.copyWith(
    fontSize: 45,
    height: 1.15,
  ),
  displaySmall: defaultTextStyle.copyWith(
    fontSize: 36,
    height: 1.22,
  ),
  headlineLarge:defaultTextStyle.copyWith(
    fontSize: 30,
    height: 1.25,
  ),
  headlineMedium: defaultTextStyle.copyWith(
    fontSize: 26,
    height: 1.28,
  ),
  headlineSmall: defaultTextStyle.copyWith(
    fontSize: 22,
    height: 1.33,
  ),
  titleLarge: defaultTextStyle.copyWith(
    fontSize: 20,
    height: 1.27,
  ),
  titleMedium: defaultTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
  ),
  titleSmall: defaultTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  ),
  bodyLarge: defaultTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
  ),
  bodyMedium: defaultTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.25,
  ),
  bodySmall: defaultTextStyle.copyWith(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  ),
  labelLarge: defaultTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  ),
  labelMedium: defaultTextStyle.copyWith(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
  ),
  labelSmall: defaultTextStyle.copyWith(
    fontSize: 8,
    height: 145,
    letterSpacing: 0.5,
  ),
);
