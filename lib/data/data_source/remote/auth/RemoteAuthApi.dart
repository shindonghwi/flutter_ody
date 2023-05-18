import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:odac_flutter_app/app/OrotApp.dart';
import 'package:odac_flutter_app/app/env/Environment.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RemoteAuthApi {
  RemoteAuthApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  final socialLoginUrl = '${Environment.apiUrl}/${Environment.apiVersion}/social_login';

  Future<ApiResponse<SocialLoginModel>> doGoogleLogin() async {
    // 구글 로그인 후 유저정보를 받아온다.
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return ApiResponse<SocialLoginModel>(
        status: 404,
        message: _getAppLocalization.get().message_not_found_user,
        data: null,
      );
    } else {
      // Google Auth Provider 를 통해 Credential 정보를 받아온다.
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 위에서 가져온 Credential 정보로 Firebase에 사용자 인증을한다.
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        return await googleUser.authentication.then(
          (value) {
            return ApiResponse<SocialLoginModel>(
              status: 200,
              message: _getAppLocalization.get().message_api_success,
              data: SocialLoginModel(
                LoginPlatform.Google,
                value.idToken,
              ),
            );
          },
        );
      } else {
        return ApiResponse<SocialLoginModel>(
          status: 404,
          message: _getAppLocalization.get().message_not_found_user,
          data: null,
        );
      }
    }
  }

  Future<ApiResponse<ResponseSocialLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  }) async {
    final response = await Service.postApi(
      type: ServiceType.Auth,
      endPoint: 'social/login',
      jsonBody: jsonEncode(requestSocialLoginModel.toJson()),
    );

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseSocialLoginModel.fromJson(json),
      );
    }
  }
}
