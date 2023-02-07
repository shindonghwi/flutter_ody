import 'package:flutter/material.dart';
import 'package:odac_flutter_app/ui/color/paletees/ColorPalettes.dart';

/**
 * @feature: light, dark Theme Color 를 정의한 파일
 *
 * @author: 2023/02/07 5:47 PM donghwishin
 *
 * @description{
 *   light 버전의 Color만 대응 되어있음. 2023/02/07 5:47 PM donghwishin
 * }
*/

ColorScheme odacColorLightScheme = ColorScheme(
  brightness: Brightness.light,

  primary: primaryPalette.shade500,
  onPrimary: primaryPalette.shade1,
  primaryContainer: primaryPalette.shade100,
  onPrimaryContainer: primaryPalette.shade900,

  secondary: secondaryPalette.shade500,
  onSecondary: secondaryPalette.shade1,
  secondaryContainer: secondaryPalette.shade100,
  onSecondaryContainer: secondaryPalette.shade900,

  error: errorPalette.shade500,
  onError: errorPalette.shade1,
  errorContainer: errorPalette.shade100,
  onErrorContainer: errorPalette.shade900,

  tertiary: tertiaryPalette.shade500,
  onTertiary: tertiaryPalette.shade1,
  tertiaryContainer: tertiaryPalette.shade100,
  onTertiaryContainer: tertiaryPalette.shade900,

  background: neutralPalette.shade1,
  onBackground: neutralPalette.shade900,

  surface: neutralPalette.shade1,
  onSurface: neutralPalette.shade900,

  surfaceVariant: neutralVariantPalette.shade100,
  onSurfaceVariant: neutralVariantPalette.shade700,

  outline: neutralVariantPalette.shade500,
  outlineVariant: neutralVariantPalette.shade200,

);
