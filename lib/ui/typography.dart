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
  fontFamily: 'Sc_Dream',
  fontWeight: FontWeight.w500,
  overflow: TextOverflow.ellipsis,
);

// Text Theme
TextTheme odacTextTheme = TextTheme(
  displayLarge: defaultTextStyle.copyWith(
    fontSize: 57,
    height: 1.12,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    height: 1.15,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    height: 1.22,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    height: 1.25,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    height: 1.28,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    height: 1.33,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    height: 1.27,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.25,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    height: 1.45,
    letterSpacing: 0.5,
  ),
);
