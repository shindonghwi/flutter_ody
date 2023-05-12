import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppDataSource.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppDataSourceImpl.dart';
import 'package:odac_flutter_app/domain/usecases/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/app/GetAppPolicyUpdateUseCase.dart';

final serviceLocator = GetIt.instance;
void initServiceLocator() {

  /// -------
  /// data source
  /// -------

  // app data source
  GetIt.instance.registerLazySingleton<LocalAppDataSource>(() => LocalAppDataSourceImpl());



  /// -------
  /// usecase
  /// -------

  //app
  GetIt.instance.registerLazySingleton<GetAppPolicyCheckUseCase>(() => GetAppPolicyCheckUseCase());
  GetIt.instance.registerLazySingleton<GetAppPolicyUpdateUseCase>(() => GetAppPolicyUpdateUseCase());

}
