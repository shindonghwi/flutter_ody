import 'dart:async';

import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';

abstract class RemoteAuthRepository  {
  /// 구글 로그인
  FutureOr<ApiResponse<SocialLoginModel>> doGoogleLogin();
}
