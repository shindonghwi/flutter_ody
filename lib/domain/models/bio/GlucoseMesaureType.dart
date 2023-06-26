enum GlucoseMeasureType{
  Fasting, // 공복,
  Preprandial, // 식전,
  Postprandial, // 식후,
  PostExercise, // 운동후,
  None, // 없음,
}


class GlucoseMeasureTypeHelper {
  static const Map<GlucoseMeasureType, String> _stringToEnum = {
    GlucoseMeasureType.Fasting: "공복",
    GlucoseMeasureType.Preprandial: "식전",
    GlucoseMeasureType.Postprandial: "식후",
    GlucoseMeasureType.PostExercise: "운동후",
    GlucoseMeasureType.None: "",
  };

  static String fromString(GlucoseMeasureType status) => _stringToEnum[status] ?? "";
}
