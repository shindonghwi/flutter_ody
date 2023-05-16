import 'package:odac_flutter_app/data/models/ApiResponse.dart';

abstract class RemoteAuthRepository  {
  /// 구글 로그인
  Future<ApiResponse<bool>> doGoogleLogin();
}
