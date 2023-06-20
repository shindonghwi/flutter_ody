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
  static const Map<YoilType, String> _stringToEnum = {
    YoilType.MONDAY: "Mon",
    YoilType.TUESDAY: "Tue",
    YoilType.WEDNESDAY: "Wed",
    YoilType.THURSDAY: "Thu",
    YoilType.FRIDAY: "Fri",
    YoilType.SATURDAY: "Sat",
    YoilType.SUNDAY: "Sun",
  };

  static String fromString(YoilType type) => _stringToEnum[type] ?? "";
}
