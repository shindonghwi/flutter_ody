import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RemoteBioApi {
  RemoteBioApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 혈압 등록 요청
  Future<ApiResponse<void>> postBloodPressure({required RequestBioBloodPressureModel data}) async {
    final response = await Service.postApi(
      type: ServiceType.Bio,
      endPoint: 'blood-pressure',
      jsonBody: data.toJson(),
    );

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => RequestBioBloodPressureModel.fromJson(json),
      );
    }
  }

  /// 혈당 등록 요청
  Future<ApiResponse<void>> postGlucose({required RequestBioGlucoseModel data}) async {
    final response = await Service.postApi(
      type: ServiceType.Bio,
      endPoint: 'glucose',
      jsonBody: data.toJson(),
    );

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => RequestBioGlucoseModel.fromJson(json),
      );
    }
  }

  /// 걸음수 등록 요청
  Future<ApiResponse<void>> postSteps({required RequestBioStepsModel data}) async {
    final response = await Service.postApi(
      type: ServiceType.Bio,
      endPoint: 'steps',
      jsonBody: data.toJson(),
    );

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => RequestBioStepsModel.fromJson(json),
      );
    }
  }

  /// 월간 건강정보 조회
  Future<ApiListResponse<List<String>>> getBioHistory(
      {required int year, required int month}) async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'history/$year/$month',
    );

    if (response.statusCode >= 500) {
      return ApiListResponse(
          status: response.statusCode,
          message: _getAppLocalization.get().message_server_error_5xx,
          list: null,
          count: 0);
    } else {
      return ApiListResponse.fromJson(
        jsonDecode(response.body),
        (json) {
          return List<String>.from(json.map((item) => item.toString()).toList());
        },
      );
    }
  }
}
