import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:odac_flutter_app/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:odac_flutter_app/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:odac_flutter_app/data/repositories/remote/auth/RemoteAuthRepositoryImpl.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:odac_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyUpdateUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  /// -------
  /// common
  /// -------
  GetIt.instance.registerLazySingleton<AppLocalization>(() => AppLocalization());


  /// -------
  /// usecase
  /// -------

  //app
  GetIt.instance.registerLazySingleton<GetAppPolicyCheckUseCase>(() => GetAppPolicyCheckUseCase());
  GetIt.instance.registerLazySingleton<GetAppPolicyUpdateUseCase>(() => GetAppPolicyUpdateUseCase());
  GetIt.instance.registerLazySingleton<PostGoogleSignInUseCase>(() => PostGoogleSignInUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
}
