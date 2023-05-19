enum GenderType {
  MALE, // 남성
  FEMALE, // 여성
}

class GenderTypeHelper {
  static const Map<GenderType, String> _stringToEnum = {
    GenderType.MALE: "MALE",
    GenderType.FEMALE: "FEMALE",
  };

  static String fromString(GenderType platform) => _stringToEnum[platform] ?? "";
}
