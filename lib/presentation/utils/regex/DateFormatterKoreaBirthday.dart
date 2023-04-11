import 'package:flutter/services.dart';

/** YYYY/MM/DD 형식 */
class DateFormatterKoreaBirthday extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    String pText = prevText.text;
    String cText = currText.text;
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 4) {
      int y2 = int.parse(cText.substring(0, 4));
      if (y2 > 1900 && y2 < 2100) {
        cText = cText.substring(0, 4);
      } else {
        cText = '';
      }
    } else if (cLen == 5 && pLen == 6) {
      cText = cText.substring(0, 4);
    } else if (cLen == 6 && pLen == 5) {
      int mm = int.parse(cText.substring(4, 6));
      String mmStr = mm.toString().padLeft(2, "0");
      if (mm > 0 && mm <= 12) {
        cText = '${cText.substring(0, 4)}/${mmStr}';
      } else {
        cText = cText.substring(0, 4);
      }
    } else if (cLen == 7 && pLen == 6) {
      int mm = int.parse(cText.substring(5, 7));
      String mmStr = mm.toString().padLeft(2, "0");
      if (mm > 0 && mm <= 12) {
        cText = '${cText.substring(0, 4)}/${mmStr}';
      } else {
        cText = cText.substring(0, 4);
      }
    } else if (cLen == 8 && pLen == 9) {
      int mm = int.parse(cText.substring(5, 7));
      String mmStr = mm.toString().padLeft(2, "0");
      cText = '${cText.substring(0, 4)}/${mmStr}';
    } else if (cLen == 9 && pLen == 8) {
      int mm = int.parse(cText.substring(5, 7));
      int dd = int.parse(cText.substring(7, 9));
      String mmStr = mm.toString().padLeft(2, "0");
      String ddStr = dd.toString().padLeft(2, "0");

      var maxDay = 31;
      if (mm == 2) maxDay = 29;

      if (dd > 0 && dd <= maxDay) {
        cText = '${cText.substring(0, 4)}/${mmStr}/${ddStr}';
      } else {
        cText = '${cText.substring(0, 4)}/${mmStr}';
      }
    }

    selectionIndex = cText.length;

    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
