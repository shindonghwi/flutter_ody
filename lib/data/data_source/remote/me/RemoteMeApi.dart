import 'dart:convert';

import 'package:ody_flutter_app/data/data_source/remote/BaseApiUtil.dart';
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

class RemoteMeApi {
  RemoteMeApi();

  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe() async {
    final response = await Service.getApi(
      type: ServiceType.Me,
      endPoint: null,
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
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 알림 설정 수정
  Future<ApiResponse<void>> patchConfigNotification(
    bool all,
    bool medicine,
    bool step,
    bool bloodPressure,
    bool glucose,
    bool report,
  ) async {
    final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: 'config/notification',
        jsonBody: Map.from({
          "all": all,
          "medicine": medicine,
          "step": step,
          "bloodPressure": bloodPressure,
          "glucose": glucose,
          "report": report,
        }));

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
          return List<ResponseMeMedicineModel>.from(
            json.map((item) => ResponseMeMedicineModel.fromJson(item as Map<String, dynamic>)),
          );
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
        (json) => null,
      );
    }
  }
}
