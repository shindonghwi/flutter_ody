import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostAppleSignInUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:ody_flutter_app/presentation/features/constant/constants.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../data/models/ApiResponse.dart';

final loginUiStateProvider =
    StateNotifierProvider<LoginUiStateNotifier, UIState<String?>>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState<String?>> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostAppleSignInUseCase get _postAppleSignInUseCase =>
      GetIt.instance<PostAppleSignInUseCase>();

  PostGoogleSignInUseCase get _postGoogleSignInUseCase =>
      GetIt.instance<PostGoogleSignInUseCase>();

  PostSocialLoginInUseCase get postSocialLoginInUseCase =>
      GetIt.instance<PostSocialLoginInUseCase>();

  GetMeInfoUseCase get getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();

  PostLoginAccessTokenUseCase get postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();


  int currentProceedPage = 0;
  ResponseMeInfoModel? meInfo;

  setServiceHeader(String? token) async {
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    final languageCode = WidgetsBinding.instance.window.locale.languageCode;
    final countryCode = WidgetsBinding.instance.window.locale.countryCode.toString();

    Service.setHeader(
      languageCode: languageCode,
      countryCode: countryCode,
      timeZone: timeZone,
      token: token ?? "",
    );
  }

  /// 회원가입 완료 여부 체크
  int getSignUpProceedPage(ResponseMeProfileModel? profile) {
    if (profile == null) return 0;

    final profileData = profile.toJson();
    if (profileData["gender"] == null) return 0;
    if (profileData["birthday"] == null) return 1;
    if ((profileData["height"] as int?) == null || profileData["height"] == 0) return 2;
    if ((profileData["weight"] as int?) == null || profileData["weight"] == 0) return 3;

    return SIGN_UP_PROCEED_COMPLETE;
  }

  void doLogin(LoginPlatform platform) async {
    state = Loading();

    switch (platform) {
      case LoginPlatform.Google:
        final googleLoginResult = await _postGoogleSignInUseCase.call();
        // 구글 로그인 성공
        if (googleLoginResult.status == 200) {
          final googleAccessToken = googleLoginResult.data?.accessToken;
          proceedSocialLogin(platform, googleAccessToken);
        } else {
          // 로그인 실패
          state = Failure(googleLoginResult.message);
        }
        break;
      case LoginPlatform.Kakao:
        state = Failure(_getAppLocalization.get().message_not_support_platform);
        break;
      case LoginPlatform.Apple:
        final appleLoginResult = await _postAppleSignInUseCase.call();
        // 애플 로그인 성공
        if (appleLoginResult.status == 200) {
          final appleAccessToken = appleLoginResult.data?.accessToken;
          proceedSocialLogin(platform, appleAccessToken);
        } else {
          // 로그인 실패
          state = Failure(appleLoginResult.message);
        }
        break;
      default:
        state = Failure(_getAppLocalization.get().message_not_support_platform);
        break;
    }
  }

  void proceedSocialLogin(LoginPlatform platform, String? token) async {
    final res = await postSocialLoginInUseCase.call(
      platform: platform,
      accessToken: token ?? "",
      deviceToken: "",
    );

    // 내 정보 요청
    await postLoginAccessToken.call(res.data?.accessToken ?? "");
    await setServiceHeader(res.data?.accessToken);
    await getMeInfoUseCase.call().then((value) {
      if (value.status == 200) {
        if (value.data != null){
          meInfo = value.data;
        }
        currentProceedPage = getSignUpProceedPage(value.data?.profile);
      }
    });

    if (res.status == 200) {
      // 로그인 성공
      state = Success(res.data?.accessToken);
    } else {
      // 로그인 실패
      state = Failure(res.message);
    }
  }

  void init(){
    state = Idle();
  }
}
