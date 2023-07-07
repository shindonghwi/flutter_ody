import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:ody_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

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
}