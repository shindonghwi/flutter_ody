import 'dart:async';

import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';

abstract class RemoteAuthRepository {
  /// 구글 로그인
  Future<ApiResponse<SocialLoginModel>> doGoogleLogin();

  /// API 소셜 로그인
  Future<ApiResponse<ResponseSocialLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  });
}
