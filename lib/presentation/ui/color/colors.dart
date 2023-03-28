import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{
  Color get primary100 => brightness == Brightness.light ? Colors.green : Colors.orange;
}