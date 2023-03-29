import 'package:flutter/material.dart';

class AppBarIcon {
  final String path;
  final Function onPressed;
  final Color? tint;

  const AppBarIcon({required this.path, required this.onPressed, this.tint = null});

  @override
  String toString() => 'AppBarIcon[$path, $onPressed, $tint]';
}
