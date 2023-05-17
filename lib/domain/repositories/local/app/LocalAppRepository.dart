import 'package:odac_flutter_app/data/models/ApiResponse.dart';

abstract class LocalAppRepository  {
  /// 앱 사용 약관 동의 체크
  Future<ApiResponse<bool>> hasAgreedToPolicy();

  /// 앱 사용 약관 동의 변경
  Future<ApiResponse<bool>> setHasAgreedToPolicy(bool value);

  /// API 액세스 토큰 가져오기
  Future<ApiResponse<String>> getAccessToken();

  /// API 액세스 토큰 저장
  Future<ApiResponse<bool>> saveAccessToken(String? token);
}
