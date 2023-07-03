import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWeeklyInfoModel.dart';
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
  Future<ApiListResponse<List<String>>> getBioHistoryMontly({required int year, required int month}) async {
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

  /// 일일 건강정보 조회
  Future<ApiResponse<ResponseBioForDaysModel>> getBioHistoryForDays(
      {required int year, required int month, required int day}) async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'history/$year/$month/$day',
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
        (json) => ResponseBioForDaysModel.fromJson(json),
      );
    }
  }

  /// 주간 보고서 목록 조회
  Future<ApiListResponse<List<ResponseBioReportListModel>>> getBioReportWeekly() async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'reports/weekly',
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
          return List<ResponseBioReportListModel>.from(
              json.map((item) => ResponseBioReportListModel.fromJson(item as Map<String, dynamic>)));
        },
      );
    }
  }

  /// 월간 보고서 목록 조회
  Future<ApiListResponse<List<ResponseBioReportListModel>>> getBioReportMonthly() async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'reports/monthly',
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
          return List<ResponseBioReportListModel>.from(
              json.map((item) => ResponseBioReportListModel.fromJson(item as Map<String, dynamic>)));
        },
      );
    }
  }

  /// 주간 보고서 정보 조회
  Future<ApiResponse<ResponseBioReportWeeklyInfoModel>> getBioReportWeeklyInfo(
      {required int reportSeq}) async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'reports/weekly/$reportSeq',
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
            (json) => ResponseBioReportWeeklyInfoModel.fromJson(json),
      );
    }
  }

}
