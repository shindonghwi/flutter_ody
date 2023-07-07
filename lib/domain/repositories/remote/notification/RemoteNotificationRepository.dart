import 'dart:async';

import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineModel.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineUpdateModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';

abstract class RemoteNotificationRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();

  /// 성별 수정
  Future<ApiResponse<void>> patchGender(GenderType type);

  /// 생년월일 수정
  Future<ApiResponse<void>> patchBirthday(String birthday);

  /// 닉네임 수정
  Future<ApiResponse<void>> patchNickname(String nick);

  /// 키 수정
  Future<ApiResponse<void>> patchHeight(int height);

  /// 몸무게 수정
  Future<ApiResponse<void>> patchWeight(int weight);

  /// 예방 질병 수정
  Future<ApiResponse<void>> patchDiseases(List<DiseaseType> diseases);

  /// 약 등록
  Future<ApiResponse<ResponseMeMedicineModel>> postMedicine(RequestMeMedicineModel data);

  /// 약 목록 조회
  Future<ApiListResponse<List<ResponseMeMedicineModel>>> getMedicines();

  /// 약 활성화 업데이트
  Future<ApiResponse<ResponseMeMedicineModel>> patchMedicine(RequestMeMedicineUpdateModel data);

  /// 약 삭제
  Future<ApiResponse<void>> deleteMedicine(int medicineSeq);

}
