import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/app/data/auth/remote/api/AuthService.dart';
import 'package:odac_flutter_app/app/data/auth/remote/api/AuthServiceImpl.dart';
import 'package:odac_flutter_app/app/data/auth/repository/AuthRepositoryImpl.dart';
import 'package:odac_flutter_app/app/domain/auth/repository/AuthRepository.dart';
import 'package:odac_flutter_app/app/domain/auth/usecase/KakaoLoginUseCase.dart';

final getIt = GetIt.instance;

class DiModule {
  Future<void> init() async {
    repositoryModule();
    useCaseModule();
    dataSourceModule();
  }

  /** @feature: Repository DI Module 정의*/
  void repositoryModule() {
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  }

  /** @feature: UseCase DI Module 정의*/
  void useCaseModule() {
    getIt.registerLazySingleton(() => KakaoLoginUseCase());
  }

  /** @feature: DataSource DI Module 정의*/
  void dataSourceModule() {
    getIt.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  }
}
