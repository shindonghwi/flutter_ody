import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';

class PostGoogleSignInUseCase {
  PostGoogleSignInUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<SocialLoginModel>> call() async {
    return await _remoteAuthRepository.doGoogleLogin();
  }

}
