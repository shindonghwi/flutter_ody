import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class PostLoginAccessTokenUseCase {
  PostLoginAccessTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<void> call(String token) async {
    return await _localAppRepository.setLoginAccessToken(token);
  }
}
