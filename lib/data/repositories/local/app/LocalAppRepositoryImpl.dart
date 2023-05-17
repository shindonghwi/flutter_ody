import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class LocalAppRepositoryImpl implements LocalAppRepository {
  LocalAppRepositoryImpl();

  @override
  Future<bool> hasAgreedToPolicy() {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.hasAgreedToPolicy();
  }

  @override
  Future<void> setHasAgreedToPolicy(bool value) {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.setHasAgreedToPolicy(true);
  }

  @override
  Future<SocialLoginModel?> getAccessToken() {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.getAccessToken();
  }

  @override
  Future<void> saveSocialAccessToken(LoginPlatform platform, String? token) {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.saveSocialAccessToken(platform, token);
  }
}
