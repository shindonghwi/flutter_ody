import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:odac_flutter_app/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyUpdateUseCase.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  /// -------
  /// usecase
  /// -------

  //app
  GetIt.instance
      .registerLazySingleton<GetAppPolicyCheckUseCase>(() => GetAppPolicyCheckUseCase());
  GetIt.instance.registerLazySingleton<GetAppPolicyUpdateUseCase>(
      () => GetAppPolicyUpdateUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance
      .registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
}
