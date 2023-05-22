import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/bio/RemoteBioApi.dart';
import 'package:odac_flutter_app/data/models/ApiListResponse.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:odac_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:odac_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:odac_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class RemoteBioRepositoryImpl implements RemoteBioRepository {
  RemoteBioRepositoryImpl();

  @override
  Future<ApiListResponse<void>> getBioHistory(int year, int month) {
    RemoteBioApi remoteBioApi = GetIt.instance<RemoteBioApi>();
    return remoteBioApi.getBioHistory(year: year, month: month);
  }

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
}
