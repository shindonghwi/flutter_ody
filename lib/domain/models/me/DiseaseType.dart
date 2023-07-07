enum DiseaseType {
  HealthCare, // 건강관리
  Hypertension, // 고혈압
  DiabetesMellitus, // 당뇨병
}

class DiseaseTypeHelper {
  static const Map<DiseaseType, String> _stringToEnum = {
    DiseaseType.HealthCare: "HealthCare",
    DiseaseType.Hypertension: "Hypertension",
    DiseaseType.DiabetesMellitus: "DiabetesMellitus",
  };

  static String fromString(DiseaseType platform) => _stringToEnum[platform] ?? "";
}
