import 'package:intl/intl.dart';

class RegexUtil{

  /// 정수만 추출
  static int extractIntegers(String input) {
    final regex = RegExp(r'\d+');
    final matches = regex.allMatches(input);

    final integers = matches.map((match) => match.group(0)).join('');

    return int.parse(integers);
  }

  static String commaNumber(num number){
    NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

}