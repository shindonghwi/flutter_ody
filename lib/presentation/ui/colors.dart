import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{

  Color get colorPrimary => primary40;
  Color get colorOnPrimary => primary100;
  Color get colorError => error40;
  Color get colorOnError => error100;
  Color get colorBackground => neutral100;
  Color get colorOnBackground => neutral10;
  Color get colorSurface => neutral100;
  Color get colorOnSurface => neutral10;

  Color get primary100 => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
  // Color get primary99 => brightness == Brightness.light ? Color(0xFFFAFBFF) : Color(0xFFFAFBFF);
  // Color get primary95 => brightness == Brightness.light ? Color(0xFFF3F7FF) : Color(0xFFF3F7FF);
  Color get primary90 => brightness == Brightness.light ? Color(0xFFECF2FF) : Color(0xFFECF2FF);
  Color get primary80 => brightness == Brightness.light ? Color(0xFFD9E5FF) : Color(0xFFD9E5FF);
  Color get primary70 => brightness == Brightness.light ? Color(0xFFC6D9FF) : Color(0xFFC6D9FF);
  Color get primary60 => brightness == Brightness.light ? Color(0xFFA0BFFF) : Color(0xFFA0BFFF);
  Color get primary50 => brightness == Brightness.light ? Color(0xFF7BA5FF) : Color(0xFF7BA5FF);
  Color get primary40 => brightness == Brightness.light ? Color(0xFF427FFF) : Color(0xFF427FFF);
  Color get primary30 => brightness == Brightness.light ? Color(0xFF366AD6) : Color(0xFF366AD6);
  Color get primary20 => brightness == Brightness.light ? Color(0xFF254587) : Color(0xFF254587);
  Color get primary10 => brightness == Brightness.light ? Color(0xFF0E1E41) : Color(0xFF0E1E41);
  Color get primary0 => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);

  Color get error100 => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
  // Color get error99 => brightness == Brightness.light ? Color(0xFFFFF8F8) : Color(0xFFFFF8F8);
  // Color get error95 => brightness == Brightness.light ? Color(0xFFFFF3F3) : Color(0xFFFFF3F3);
  Color get error90 => brightness == Brightness.light ? Color(0xFFFFECEC) : Color(0xFFFFECEC);
  Color get error80 => brightness == Brightness.light ? Color(0xFFFFD9D9) : Color(0xFFFFD9D9);
  Color get error70 => brightness == Brightness.light ? Color(0xFFFFC6C6) : Color(0xFFFFC6C6);
  Color get error60 => brightness == Brightness.light ? Color(0xFFFF7B7B) : Color(0xFFFF7B7B);
  Color get error50 => brightness == Brightness.light ? Color(0xFFFF6868) : Color(0xFFFF6868);
  Color get error40 => brightness == Brightness.light ? Color(0xFFFF4242) : Color(0xFFFF4242);
  Color get error30 => brightness == Brightness.light ? Color(0xFFD63333) : Color(0xFFD63333);
  Color get error20 => brightness == Brightness.light ? Color(0xFF9F2929) : Color(0xFF9F2929);
  Color get error10 => brightness == Brightness.light ? Color(0xFF551515) : Color(0xFF551515);
  Color get error0 => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);

  Color get neutral100 => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
  Color get neutral99 => brightness == Brightness.light ? Color(0xFFFAFAFA) : Color(0xFFFAFAFA);
  Color get neutral95 => brightness == Brightness.light ? Color(0xFFF6F6F6) : Color(0xFFF6F6F6);
  Color get neutral90 => brightness == Brightness.light ? Color(0xFFF6F6F6) : Color(0xFFF6F6F6);
  Color get neutral80 => brightness == Brightness.light ? Color(0xFFEAEAEA) : Color(0xFFEAEAEA);
  Color get neutral70 => brightness == Brightness.light ? Color(0xFFD4D4D4) : Color(0xFFD4D4D4);
  Color get neutral60 => brightness == Brightness.light ? Color(0xFFB7B7B7) : Color(0xFFB7B7B7);
  Color get neutral50 => brightness == Brightness.light ? Color(0xFF8E8E8E) : Color(0xFF8E8E8E);
  Color get neutral40 => brightness == Brightness.light ? Color(0xFF666666) : Color(0xFF666666);
  Color get neutral30 => brightness == Brightness.light ? Color(0xFF515151) : Color(0xFF515151);
  Color get neutral20 => brightness == Brightness.light ? Color(0xFF3D3D3D) : Color(0xFF3D3D3D);
  Color get neutral10 => brightness == Brightness.light ? Color(0xFF282828) : Color(0xFF282828);
  Color get neutral0 => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);
}