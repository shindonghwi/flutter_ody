import 'package:flutter/material.dart';

/**
 * @feature: Material Color 팔레트를 셋팅하는 파일
 *
 * @author: 2023/02/07 5:46 PM donghwishin
 *
 * @description{
 *   shade 1~900 값은 피그마에 디자인 컬러로 셋팅된 정보이다.
 * }
 */
class ColorPalettes extends ColorSwatch<int> {
  ColorPalettes(super.primary, super.swatch);

  Color get shade1 => this[1]!;

  Color get shade50 => this[50]!;

  Color get shade100 => this[100]!;

  Color get shade200 => this[200]!;

  Color get shade300 => this[300]!;

  Color get shade400 => this[400]!;

  Color get shade500 => this[500]!;

  Color get shade600 => this[600]!;

  Color get shade700 => this[700]!;

  Color get shade800 => this[800]!;

  Color get shade900 => this[900]!;
}

ColorPalettes primaryPalette = ColorPalettes(
  0xFF2D874D,
  <int, Color>{
    1: Color(0xFFFCFCFC),
    50: Color(0xFFC4FFCD),
    100: Color(0xFF9CF6B1),
    200: Color(0xFF81D997),
    300: Color(0xFF66BD7E),
    400: Color(0xFF4AA265),
    500: Color(0xFF2D874D),
    600: Color(0xFF056D37),
    700: Color(0xFF005227),
    800: Color(0xFF003919),
    900: Color(0xFF00210C),
  },
);

ColorPalettes secondaryPalette = ColorPalettes(
  0xFF687C6A,
  <int, Color>{
    1: Color(0xFFFCFCFC),
    50: Color(0xFFE1F7E1),
    100: Color(0xFFD3E8D3),
    200: Color(0xFFB7CCB7),
    300: Color(0xFF9CB19D),
    400: Color(0xFF819683),
    500: Color(0xFF687C6A),
    600: Color(0xFF506352),
    700: Color(0xFF394B3B),
    800: Color(0xFF233426),
    900: Color(0xFF0E1F12),
  },
);

ColorPalettes tertiaryPalette = ColorPalettes(
  0xFF537E87,
  <int, Color>{
    1: Color(0xFFFCFCFC),
    50: Color(0xFFD5F6FF),
    100: Color(0xFFBDEAF5),
    200: Color(0xFFA2CED9),
    300: Color(0xFF87B2BD),
    400: Color(0xFF6D98A2),
    500: Color(0xFF537E87),
    600: Color(0xFF3A656E),
    700: Color(0xFF204D56),
    800: Color(0xFF01363F),
    900: Color(0xFF001F25),
  },
);

ColorPalettes errorPalette = ColorPalettes(
  0xFFDE3730,
  <int, Color>{
    1: Color(0xFFFCFCFC),
    50: Color(0xFFFFEDEA),
    100: Color(0xFFFFDAD6),
    200: Color(0xFFFFB4AB),
    300: Color(0xFFFF897D),
    400: Color(0xFFFF5449),
    500: Color(0xFFDE3730),
    600: Color(0xFFBA1A1A),
    700: Color(0xFF93000A),
    800: Color(0xFF690005),
    900: Color(0xFF410002),
  },
);

ColorPalettes neutralPalette = ColorPalettes(
  0xFF757874,
  <int, Color>{
    1: Color(0xFFFDFCF8),
    50: Color(0xFFF0F1EC),
    100: Color(0xFFE2E3DE),
    200: Color(0xFFC5C7C2),
    300: Color(0xFFAAACA7),
    400: Color(0xFF8F918D),
    500: Color(0xFF757874),
    600: Color(0xFF5C5F5B),
    700: Color(0xFF454744),
    800: Color(0xFF2E312E),
    900: Color(0xFF191C19),
  },
);

ColorPalettes neutralVariantPalette = ColorPalettes(
  0xFF757874,
  <int, Color>{
    1: Color(0xFFFDFCF8),
    50: Color(0xFFEBF3E8),
    100: Color(0xFFDDE5DA),
    200: Color(0xFFC1C9BF),
    300: Color(0xFFA5ADA4),
    400: Color(0xFF8B938A),
    500: Color(0xFF717971),
    600: Color(0xFF596058),
    700: Color(0xFF414941),
    800: Color(0xFF2B322B),
    900: Color(0xFF161D17),
  },
);
