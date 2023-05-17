import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final loginUiStateProvider = StateNotifierProvider<LoginUiStateNotifier, UIState>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState> {
  LoginUiStateNotifier() : super(Idle());

  PostGoogleSignInUseCase get _postGoogleSignInUseCase =>
      GetIt.instance<PostGoogleSignInUseCase>();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  void doLogin(LoginPlatform platform) async {
    state = Loading();

    switch (platform) {
      case LoginPlatform.Google:
        final googleLoginResult = await _postGoogleSignInUseCase.call();
        if (googleLoginResult.status == 200) {
          state = Success<String?>(googleLoginResult.data?.accessToken);
        } else {
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
