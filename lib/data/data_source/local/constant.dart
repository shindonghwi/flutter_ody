enum SharedKey {
  APP_USE_POLICY, // 앱 사용 약관 동의
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.APP_USE_POLICY: "APP_USE_POLICY",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;

}
