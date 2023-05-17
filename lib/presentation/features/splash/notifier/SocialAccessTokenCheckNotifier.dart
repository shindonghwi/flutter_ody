import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAccessTokenUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/PostSaveSocialTokenUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final socialAccessTokenCheckProvider = StateNotifierProvider<SocialAccessTokenCheckNotifier, String>(
  (_) => SocialAccessTokenCheckNotifier(),
);

class SocialAccessTokenCheckNotifier extends StateNotifier<String> {
  SocialAccessTokenCheckNotifier() : super("");

  GetAccessTokenUseCase get getAccessTokenUseCase =>
      GetIt.instance<GetAccessTokenUseCase>();

  Future<SocialLoginModel?> hasAccessToken() async {
    return await getAccessTokenUseCase.call();
  }
}
