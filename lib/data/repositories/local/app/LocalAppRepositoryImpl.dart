import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class LocalAppRepositoryImpl implements LocalAppRepository {
  LocalAppRepositoryImpl();

  @override
  Future<ApiResponse<bool>> hasAgreedToPolicy() {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.hasAgreedToPolicy();
  }

  @override
  Future<ApiResponse<bool>> setHasAgreedToPolicy(bool value) {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.setHasAgreedToPolicy(true);
  }

  @override
  Future<ApiResponse<String>> getAccessToken() {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.getAccessToken();
  }

  @override
  Future<ApiResponse<bool>> saveAccessToken(String? token) {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.saveAccessToken(token);
  }
}
