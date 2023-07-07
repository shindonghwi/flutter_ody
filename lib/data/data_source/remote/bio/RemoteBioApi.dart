import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ody_flutter_app/data/data_source/remote/BaseApiUtil.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';

class RemoteBioApi {
  RemoteBioApi();

  /// 혈압 등록 요청
  Future<ApiResponse<void>> postBloodPressure({required RequestBioBloodPressureModel data}) async {
    final response = await Service.postApi(
      type: ServiceType.Bio,
      endPoint: 'blood-pressure',
      jsonBody: data.toJson(),
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
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

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
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

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
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

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiListResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        list: null,
        count: 0,
      );
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

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
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

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiListResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        list: null,
        count: 0,
      );
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

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiListResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        list: null,
        count: 0,
      );
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
  Future<ApiResponse<ResponseBioReportInfoModel>> getBioReportWeeklyInfo({required int reportSeq}) async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'reports/weekly/$reportSeq',
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) {
          debugPrint('asdasd json: ${json == null ? 'null' : 'not null'}');
          return ResponseBioReportInfoModel.fromJson(json);
        },
      );
    }
  }

  /// 월간 보고서 정보 조회
  Future<ApiResponse<ResponseBioReportInfoModel>> getBioReportMonthlyInfo({required int reportSeq}) async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'reports/monthly/$reportSeq',
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseBioReportInfoModel.fromJson(json),
      );
    }
  }
}
