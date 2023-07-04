import 'dart:async';

import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';

abstract class RemoteBioRepository {
  /// 혈압 등록 요청
  Future<ApiResponse<void>> postBloodPressure(RequestBioBloodPressureModel data);

  /// 혈당 등록 요청
  Future<ApiResponse<void>> postGlucose(RequestBioGlucoseModel data);

  /// 혈당 등록 요청
  Future<ApiResponse<void>> postSteps(RequestBioStepsModel data);

  /// 월간 건강정보 조회
  Future<ApiListResponse<List<String>>> getBioHistoryMontly(int year, int month);

  /// 일간 건강정보 조회
  Future<ApiResponse<ResponseBioForDaysModel>> getBioHistoryForDays(int year, int month, int day);

  /// 주간 보고서 목록 조회
  Future<ApiListResponse<List<ResponseBioReportListModel>>> getBioReportWeekly();

  /// 월간 보고서 목록 조회
  Future<ApiListResponse<List<ResponseBioReportListModel>>> getBioReportMonthly();

  /// 주간 보고서 정보 조회
  Future<ApiResponse<ResponseBioReportInfoModel>> getBioReportWeeklyInfo(int reportSeq);

  /// 월간 보고서 정보 조회
  Future<ApiResponse<ResponseBioReportInfoModel>> getBioReportMonthlyInfo(int reportSeq);
}
