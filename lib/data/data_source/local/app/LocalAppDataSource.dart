abstract class LocalAppDataSource {
  /// 앱 사용 약관 동의 체크
  Future<bool> hasAgreedToPolicy();

  /// 앱 사용 약관 동의 변경
  Future<void> setHasAgreedToPolicy(bool value);
}
