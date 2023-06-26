import 'dart:async';

import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';

abstract class RemoteBioRepository {
  /// 혈압 등록 요청
  Future<ApiResponse<void>> postBloodPressure(RequestBioBloodPressureModel data);

  /// 혈당 등록 요청
  Future<ApiResponse<void>> postGlucose(RequestBioGlucoseModel data);

  /// 혈당 등록 요청
  Future<ApiResponse<void>> postSteps(RequestBioStepsModel data);

  /// 월간 건강정보 조회
  Future<ApiListResponse<void>> getBioHistoryMontly(int year, int month);

  /// 일간 건강정보 조회
  Future<ApiResponse<ResponseBioForDaysModel>> getBioHistoryForDays(int year, int month, int day);

}
