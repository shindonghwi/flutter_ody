abstract class LocalAppRepository {
  /// 앱 사용 약관 동의 체크
  Future<bool> hasAgreedToPolicy();

  /// 앱 사용 약관 동의 변경
  Future<void> setHasAgreedToPolicy(bool value);

  /// 로그인 후 발급 받은 토큰 가져오기
  Future<String> getLoginAccessToken();

  /// 로그인 후 발급 받은 토큰 저장하기
  Future<void> setLoginAccessToken(String token);

}
