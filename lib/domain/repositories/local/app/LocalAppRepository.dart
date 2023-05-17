import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';

abstract class LocalAppRepository {
  /// 앱 사용 약관 동의 체크
  Future<bool> hasAgreedToPolicy();

  /// 앱 사용 약관 동의 변경
  Future<void> setHasAgreedToPolicy(bool value);

  /// API 액세스 토큰 가져오기
  Future<SocialLoginModel?> getAccessToken();

  /// API 액세스 토큰 저장
  Future<void> saveSocialAccessToken(LoginPlatform platform, String? token);
}
