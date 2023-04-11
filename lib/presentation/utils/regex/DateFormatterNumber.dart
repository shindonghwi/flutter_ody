import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odac_flutter_app/presentation/utils/regex/model/Exceptions.dart';

class DateFormatterNumber extends TextInputFormatter {
  final minValue;
  final maxValue;

  DateFormatterNumber({
    required this.minValue,
    required this.maxValue,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    Exceptions? exception = null;
    String pText = prevText.text;
    String cText = currText.text;
    int cLen = cText.length;
    int pLen = pText.length;

    if (isNumeric(cText)) {
      int num = int.parse(cText);
      if (num < minValue || num > maxValue) {
        exception = Exceptions.RangeException;
      }
    } else if (cLen != 0) {
      exception = Exceptions.TypeException;
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  bool isNumeric(String str) {
    return RegExp(r'^-?[0-9]+$').hasMatch(str);
  }
}
