import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FixedInputFormatter extends TextInputFormatter {
  final String suffix;

  FixedInputFormatter({required this.suffix});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final beforeSuffix = newValue.text.endsWith(suffix)
        ? newValue.text.substring(0, newValue.text.length - suffix.length)
        : newValue.text;

    final cursorPosition = newValue.selection.baseOffset;
    final cursorOffset = beforeSuffix.length <= cursorPosition ? beforeSuffix.length : cursorPosition;

    final newString = '$beforeSuffix$suffix';

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );
  }
}
