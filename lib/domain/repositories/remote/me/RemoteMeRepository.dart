import 'dart:async';

import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';

abstract class RemoteMeRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();
}
