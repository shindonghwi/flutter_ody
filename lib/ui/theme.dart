import 'package:flutter/material.dart';
import 'package:odac_flutter_app/ui/color/color.dart';
import 'package:odac_flutter_app/ui/typography.dart';

/**
 * @feature: Theme 정의
 *
 * @author: 2023/02/07 5:48 PM donghwishin
 *
 * @description{
 *   Color Theme 는 System Color Theme에 따라 변경되도록 구현
 * }
*/
class AppTheme {
  AppTheme._();

  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: odacTextTheme,
    colorScheme: odacColorLightScheme,
    scaffoldBackgroundColor: Colors.white,
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: odacTextTheme,
    colorScheme: odacColorLightScheme,
    scaffoldBackgroundColor: Colors.white,
  );
}
