import 'package:odac_flutter_app/data/models/ApiResponse.dart';

abstract class LocalAppRepository  {
  /// 앱 사용 약관 동의 체크
  Future<ApiResponse<bool>> hasAgreedToPolicy();

  /// 앱 사용 약관 동의 변경
  Future<ApiResponse<bool>> setHasAgreedToPolicy(bool value);
}
