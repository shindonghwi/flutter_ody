enum GlucoseMeasureType{
  Fasting, // 공복,
  BeforeMeal, // 식전,
  AfterMeals, // 식후,
  PostWorkout, // 운동후,
  None, // 없음,
}


class GlucoseMeasureTypeHelper {
  static const Map<GlucoseMeasureType, String> _stringToEnum = {
    GlucoseMeasureType.Fasting: "공복",
    GlucoseMeasureType.BeforeMeal: "식전",
    GlucoseMeasureType.AfterMeals: "식후",
    GlucoseMeasureType.PostWorkout: "운동후",
    GlucoseMeasureType.None: "",
  };

  static String fromString(GlucoseMeasureType status) => _stringToEnum[status] ?? "";
}
