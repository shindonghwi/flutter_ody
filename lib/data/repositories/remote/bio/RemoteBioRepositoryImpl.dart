import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/bio/RemoteBioApi.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class RemoteBioRepositoryImpl implements RemoteBioRepository {
  RemoteBioRepositoryImpl();

  @override
  Future<ApiResponse<void>> postBloodPressure(RequestBioBloodPressureModel data) {
    RemoteBioApi remoteBioApi = GetIt.instance<RemoteBioApi>();
    return remoteBioApi.postBloodPressure(data: data);
  }

  @override
  Future<ApiResponse<void>> postGlucose(RequestBioGlucoseModel data) {
    RemoteBioApi remoteBioApi = GetIt.instance<RemoteBioApi>();
    return remoteBioApi.postGlucose(data: data);
  }

  @override
  Future<ApiResponse<void>> postSteps(RequestBioStepsModel data) {
    RemoteBioApi remoteBioApi = GetIt.instance<RemoteBioApi>();
    return remoteBioApi.postSteps(data: data);
  }

  @override
  Future<ApiListResponse<void>> getBioHistoryForDays(int year, int month, int day) {
    RemoteBioApi remoteBioApi = GetIt.instance<RemoteBioApi>();
    return remoteBioApi.getBioHistoryForDays(year: year, month: month, day: day);
  }

  @override
  Future<ApiListResponse<void>> getBioHistoryMontly(int year, int month) {
    RemoteBioApi remoteBioApi = GetIt.instance<RemoteBioApi>();
    return remoteBioApi.getBioHistoryMontly(year: year, month: month);
  }
}
