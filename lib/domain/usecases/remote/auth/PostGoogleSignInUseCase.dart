import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';

class PostGoogleSignInUseCase {
  PostGoogleSignInUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<bool>> call() async {
    return await _remoteAuthRepository.doGoogleLogin();
  }

}
