import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:ody_flutter_app/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:ody_flutter_app/data/data_source/remote/bio/RemoteBioApi.dart';
import 'package:ody_flutter_app/data/data_source/remote/me/RemoteMeApi.dart';
import 'package:ody_flutter_app/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:ody_flutter_app/data/repositories/remote/auth/RemoteAuthRepositoryImpl.dart';
import 'package:ody_flutter_app/data/repositories/remote/bio/RemoteBioRepositoryImpl.dart';
import 'package:ody_flutter_app/data/repositories/remote/me/RemoteMeRepositoryImpl.dart';
import 'package:ody_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:ody_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';
import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:ody_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/local/app/GetAppPolicyUpdateUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryForDaysUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryMontlyUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportMontlyUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportWeeklyUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/PostBioBloodPressureUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/PostBioGlucoseUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/PostBioStepsUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/DeleteMedicineUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/GetMeMedicinesUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeBirthdayUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeDiseasesUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeGenderUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeHeightUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeMedicineUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeNicknameUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeWeightUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PostMeMedicineUseCase.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

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
  GetIt.instance.registerLazySingleton<PostSocialLoginInUseCase>(() => PostSocialLoginInUseCase());

  GetIt.instance.registerLazySingleton<GetMeInfoUseCase>(() => GetMeInfoUseCase());
  GetIt.instance.registerLazySingleton<PatchMeGenderUseCase>(() => PatchMeGenderUseCase());
  GetIt.instance.registerLazySingleton<PatchMeBirthdayUseCase>(() => PatchMeBirthdayUseCase());
  GetIt.instance.registerLazySingleton<PatchMeNicknameUseCase>(() => PatchMeNicknameUseCase());
  GetIt.instance.registerLazySingleton<PatchMeHeightUseCase>(() => PatchMeHeightUseCase());
  GetIt.instance.registerLazySingleton<PatchMeWeightUseCase>(() => PatchMeWeightUseCase());
  GetIt.instance.registerLazySingleton<PatchMeDiseasesUseCase>(() => PatchMeDiseasesUseCase());
  GetIt.instance.registerLazySingleton<GetMeMedicinesUseCase>(() => GetMeMedicinesUseCase());
  GetIt.instance.registerLazySingleton<PatchMeMedicineUseCase>(() => PatchMeMedicineUseCase());
  GetIt.instance.registerLazySingleton<PostMeMedicineUseCase>(() => PostMeMedicineUseCase());
  GetIt.instance.registerLazySingleton<DeleteMedicineUseCase>(() => DeleteMedicineUseCase());

  GetIt.instance.registerLazySingleton<PostBioBloodPressureUseCase>(() => PostBioBloodPressureUseCase());
  GetIt.instance.registerLazySingleton<PostBioGlucoseUseCase>(() => PostBioGlucoseUseCase());
  GetIt.instance.registerLazySingleton<PostBioStepsUseCase>(() => PostBioStepsUseCase());
  GetIt.instance.registerLazySingleton<GetBioHistoryMontlyUseCase>(() => GetBioHistoryMontlyUseCase());
  GetIt.instance.registerLazySingleton<GetBioHistoryForDaysUseCase>(() => GetBioHistoryForDaysUseCase());
  GetIt.instance.registerLazySingleton<GetBioReportMonthlyUseCase>(() => GetBioReportMonthlyUseCase());
  GetIt.instance.registerLazySingleton<GetBioReportWeeklyUseCase>(() => GetBioReportWeeklyUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteMeRepository>(() => RemoteMeRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteBioRepository>(() => RemoteBioRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
  GetIt.instance.registerLazySingleton<RemoteMeApi>(() => RemoteMeApi());
  GetIt.instance.registerLazySingleton<RemoteBioApi>(() => RemoteBioApi());
}
