
import 'package:flutter/cupertino.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class CalendarSize {

  static double minHeight(BuildContext context){
    return getMediaQuery(context).size.height * 0.16;
  }
  static double maxHeight(BuildContext context){
    return getMediaQuery(context).size.height * 0.39;
  }
  static double turningHeight(BuildContext context){
    return getMediaQuery(context).size.height * 0.27;
  }
}