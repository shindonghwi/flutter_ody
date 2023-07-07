import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/app/env/Environment.dart';
import 'package:ody_flutter_app/data/data_source/remote/BaseApiUtil.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class RemoteAuthApi {
  RemoteAuthApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<ApiResponse<SocialLoginModel>> doAppleLogin() async {
    if (await Service.isNetworkAvailable()) {
      final rawNonce = generateNonce();

      final redirectURL = Environment.buildType == BuildType.dev
          ? "https://app-ody-dev.glitch.me/callbacks/sign_in_with_apple"
          : "https://app-ody.glitch.me/callbacks/sign_in_with_apple";
      final clientID = Environment.buildType == BuildType.dev ? "dev.ody.orot.com" : "ody.orot.com";

      print("redirectURL: ${redirectURL}");
      print("clientID: ${clientID}");

      final nonce = _sha256ofString(rawNonce);
      try {
        final appleIdCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID,
            redirectUri: Uri.parse(redirectURL),
          ),
          nonce: nonce,
        );
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: appleIdCredential.identityToken,
          accessToken: appleIdCredential.authorizationCode,
          rawNonce: rawNonce,
        );

        final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          return ApiResponse<SocialLoginModel>(
            status: 200,
            message: _getAppLocalization.get().message_api_success,
            data: SocialLoginModel(
              LoginPlatform.Apple,
              appleIdCredential.identityToken,
            ),
          );
        } else {
          return ApiResponse<SocialLoginModel>(
            status: 404,
            message: _getAppLocalization.get().message_not_found_user,
            data: null,
          );
        }
      } catch (e) {
        print("error: ${e.toString()}");
        return ApiResponse<SocialLoginModel>(
          status: 400,
          message: "${e.toString()}",
          data: null,
        );
      }
    } else {
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message: _getAppLocalization.get().message_network_required,
        data: null,
      );
    }
  }

  Future<ApiResponse<SocialLoginModel>> doGoogleLogin() async {
    if (await Service.isNetworkAvailable()) {
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
        final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
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
    } else {
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message: _getAppLocalization.get().message_network_required,
        data: null,
      );
    }
  }

  Future<ApiResponse<ResponseSocialLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  }) async {
    final response = await Service.postApi(
      type: ServiceType.Auth,
      endPoint: 'social/login',
      jsonBody: requestSocialLoginModel.toJson(),
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
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
