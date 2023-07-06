import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineModel.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineUpdateModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
import 'package:ody_flutter_app/domain/models/me/YoilType.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RemoteMeApi {
  RemoteMeApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 내 정보 요청
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

  /// 회원 탈퇴
  Future<ApiResponse<void>> postLeave(String reason) async {
    final response = await Service.postApi(
      type: ServiceType.Me,
      endPoint: 'leave',
      jsonBody: Map.from({
        "reason": reason,
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
          "diseases": diseases.map((disease) => DiseaseTypeHelper.fromString(disease)).toList(),
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

  /// 약 등록
  Future<ApiResponse<ResponseMeMedicineModel>> postMedicine({required RequestMeMedicineModel data}) async {
    final dayList = [];
    for (var element in data.days) {
      dayList.add(YoilTypeHelper.fromString(element));
    }

    final response = await Service.postApi(
        type: ServiceType.Me,
        endPoint: 'medicine',
        jsonBody: Map.from({
          "name": data.name,
          "days": dayList,
          "time": data.time,
          "enabled": data.enabled,
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
        (json) => ResponseMeMedicineModel.fromJson(json),
      );
    }
  }

  /// 약 목록 조회
  Future<ApiListResponse<List<ResponseMeMedicineModel>>> getMedicines() async {
    final response = await Service.getApi(
      type: ServiceType.Me,
      endPoint: 'medicines',
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
          return List<ResponseMeMedicineModel>.from(
              json.map((item) => ResponseMeMedicineModel.fromJson(item as Map<String, dynamic>)));
        },
      );
    }
  }

  /// 약 활성화 업데이트
  Future<ApiResponse<ResponseMeMedicineModel>> patchMedicine({
    required RequestMeMedicineUpdateModel data,
  }) async {
    final response = await Service.patchApi(
      type: ServiceType.Me,
      endPoint: 'medicine',
      jsonBody: data.toJson(),
    );

    if (response.statusCode >= 500) {
      return ApiResponse(
          status: response.statusCode, message: _getAppLocalization.get().message_server_error_5xx, data: null);
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeMedicineModel.fromJson(json),
      );
    }
  }

  /// 약 삭제
  Future<ApiResponse<void>> deleteMedicine({
    required int medicineSeq,
  }) async {
    final response = await Service.deleteApi(
      type: ServiceType.Me,
      endPoint: 'medicine/$medicineSeq',
      jsonBody: null,
    );

    if (response.statusCode >= 500) {
      return ApiResponse(
          status: response.statusCode, message: _getAppLocalization.get().message_server_error_5xx, data: null);
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => null,
      );
    }
  }
}
