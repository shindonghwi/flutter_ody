import 'package:flutter/cupertino.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class CalendarSize {
  static double _getMinRatio() => 0.16;

  static double minHeight(BuildContext context) {
    return getMediaQuery(context).size.height * (_getMinRatio());
  }

  static double maxHeight(BuildContext context) {
    return getMediaQuery(context).size.height * (_getMinRatio() + 0.23);
  }

  static double turningHeight(BuildContext context) {
    return getMediaQuery(context).size.height * (_getMinRatio() + 0.11);
  }

  static double underMargin(BuildContext context) {
    return getMediaQuery(context).size.height * (_getMinRatio() + 0.03);
  }
}
