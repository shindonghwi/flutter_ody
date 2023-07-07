import 'dart:ui';

enum YoilType {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
  SUNDAY,
}

class YoilTypeHelper {
  static const Map<YoilType, String> _enumToString = {
    YoilType.MONDAY: "Mon",
    YoilType.TUESDAY: "Tue",
    YoilType.WEDNESDAY: "Wed",
    YoilType.THURSDAY: "Thu",
    YoilType.FRIDAY: "Fri",
    YoilType.SATURDAY: "Sat",
    YoilType.SUNDAY: "Sun",
  };

  static const Map<String, YoilType> _stringToEnum = {
    "Mon": YoilType.MONDAY,
    "Tue": YoilType.TUESDAY,
    "Wed": YoilType.WEDNESDAY,
    "Thu": YoilType.THURSDAY,
    "Fri": YoilType.FRIDAY,
    "Sat": YoilType.SATURDAY,
    "Sun": YoilType.SUNDAY,
  };

  static String fromString(YoilType type) => _enumToString[type] ?? "";

  static YoilType? stringToYoilType(String text){
    return _stringToEnum[text];
  }

  static String yoilTypeCodeToText(YoilType? type){
     switch(type){
        case YoilType.MONDAY:
          return window.locales.contains("en") ? "Mon" :"월";
        case YoilType.TUESDAY:
          return window.locales.contains("en") ? "Tue" :"화";
        case YoilType.WEDNESDAY:
          return window.locales.contains("en") ? "Wed" :"수";
        case YoilType.THURSDAY:
          return window.locales.contains("en") ? "Thu" :"목";
        case YoilType.FRIDAY:
          return window.locales.contains("en") ? "Fri" :"금";
        case YoilType.SATURDAY:
          return window.locales.contains("en") ? "Sat" :"토";
        case YoilType.SUNDAY:
          return window.locales.contains("en") ? "Sun" :"일";
        default:
          return "";
     }
  }

}
