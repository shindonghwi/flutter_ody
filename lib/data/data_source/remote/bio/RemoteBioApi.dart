import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/app/env/Environment.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
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
  Future<ApiListResponse<void>> getBioHistory({required int year, required int month}) async {
    final response = await Service.getApi(
      type: ServiceType.Bio,
      endPoint: 'history/$year/$month',
    );

    if (response.statusCode >= 500) {
      return ApiListResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        list: null,
        count: 0
      );
    } else {
      return ApiListResponse.fromJson(
        jsonDecode(response.body),
        (json) => null,
      );
    }
  }


}
