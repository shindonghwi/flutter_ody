import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/PostSaveSocialTokenUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final loginUiStateProvider = StateNotifierProvider<LoginUiStateNotifier, UIState>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostGoogleSignInUseCase get _postGoogleSignInUseCase =>
      GetIt.instance<PostGoogleSignInUseCase>();

  PostSocialLoginInUseCase get postSocialLoginInUseCase =>
      GetIt.instance<PostSocialLoginInUseCase>();

  PostSaveSocialTokenUseCase get postSaveSocialAccessTokenUseCase =>
      GetIt.instance<PostSaveSocialTokenUseCase>();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  void doLogin(LoginPlatform platform) async {
    state = Loading();

    switch (platform) {
      case LoginPlatform.Google:
        final googleLoginResult = await _postGoogleSignInUseCase.call();
        // 구글 로그인 성공
        if (googleLoginResult.status == 200) {
          // 소셜 회원가입 / 로그인 요청
          final googleAccessToken = googleLoginResult.data?.accessToken;

          // 소셜 토큰 정보 저장
          await postSaveSocialAccessTokenUseCase.call(platform, googleAccessToken);

          final res = await postSocialLoginInUseCase.call(
            platform: platform,
            accessToken: googleAccessToken ?? "",
            deviceToken: "",
          );

          if (res.status == 200) {
            // 로그인 성공
            state = Success(res.data?.accessToken);
          } else {
            // 로그인 실패
            state = Failure(res.message);
          }
        }
        // 구글 로그인 실패
        else {
          state = Failure(googleLoginResult.message);
        }
        break;
      case LoginPlatform.Kakao:
        state = Failure(_getAppLocalization.get().message_not_support_platform);
        break;
      case LoginPlatform.Apple:
        state = Failure(_getAppLocalization.get().message_not_support_platform);
        break;
      default:
        state = Failure(_getAppLocalization.get().message_not_support_platform);
        break;
    }
  }
}
