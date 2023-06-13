import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:odac_flutter_app/domain/models/me/GenderType.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RemoteMeApi {
  RemoteMeApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  Future<ApiResponse<ResponseMeInfoModel>> getMe() async {
    final response = await Service.getApi(
      type: ServiceType.Me,
      endPoint: null,
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
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 성별 수정
  Future<ApiResponse<void>> patchGender({required GenderType type}) async {
    final response = await Service.patchApi(
      type: ServiceType.Me,
      endPoint: 'gender',
      jsonBody: Map.from({
        "gender": GenderTypeHelper.fromString(type),
      }),
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
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 생년월일 수정
  Future<ApiResponse<void>> patchBirthday({required String birthday}) async {
    final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: 'birthday',
        jsonBody: Map.from({
          "birthday": birthday,
        }));

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 닉네임 수정
  Future<ApiResponse<void>> patchNickname({required String nick}) async {
    final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: 'nick',
        jsonBody: Map.from({
          "nick": nick,
        }));

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
            (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }


  /// 키 수정
  Future<ApiResponse<void>> patchHeight({required int height}) async {
    final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: 'height',
        jsonBody: Map.from({
          "height": height,
        }));

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 몸무게 수정
  Future<ApiResponse<void>> patchWeight({required int weight}) async {
    final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: 'weight',
        jsonBody: Map.from({
          "weight": weight,
        }));

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 예방 질병 정보 수정
  Future<ApiResponse<void>> patchDiseases({required List<DiseaseType> diseases}) async {
    final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: 'preventive/disease',
        jsonBody: Map.from({
          "diseases":
              diseases.map((disease) => DiseaseTypeHelper.fromString(disease)).toList(),
        }));

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }
}
