import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class PostSaveAccessTokenUseCase {
  PostSaveAccessTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<ApiResponse<bool>> call(String? token) async {
    return await _localAppRepository.saveAccessToken(token);
  }
}
