import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class PostSaveSocialTokenUseCase {
  PostSaveSocialTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<void> call(LoginPlatform platform, String? token) async {
    return await _localAppRepository.saveSocialAccessToken(platform, token);
  }
}
