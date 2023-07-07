import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportStatesModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWeeksModel.dart';

part 'ResponseBioReportGlucoseModel.g.dart';

@JsonSerializable()
class ResponseBioReportGlucoseModel {
  final int totalCount;
  final int minFastingGlucose;
  final int maxFastingGlucose;
  final int minPreprandialGlucose;
  final int maxPreprandialGlucose;
  final int minPostprandialGlucose;
  final int maxPostprandialGlucose;
  final int minPostExerciseGlucose;
  final int maxPostExerciseGlucose;
  final List<ResponseBioReportStatesModel>? states;
  final List<ResponseBioReportDaysModel>? days;
  final List<ResponseBioReportWeeksModel>? weeks;

  ResponseBioReportGlucoseModel({
    this.totalCount = 0,
    this.minFastingGlucose = 0,
    this.maxFastingGlucose = 0,
    this.minPreprandialGlucose = 0,
    this.maxPreprandialGlucose = 0,
    this.minPostprandialGlucose = 0,
    this.maxPostprandialGlucose = 0,
    this.minPostExerciseGlucose = 0,
    this.maxPostExerciseGlucose = 0,
    this.states,
    this.days,
    this.weeks,
  });

  factory ResponseBioReportGlucoseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportGlucoseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportGlucoseModelToJson(this);
}
