import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportStatesModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';

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
  final List<ResponseBioReportStatesModel> states;
  final List<ResponseBioReportDaysModel> days;

  ResponseBioReportGlucoseModel({
    required this.totalCount,
    required this.minFastingGlucose,
    required this.maxFastingGlucose,
    required this.minPreprandialGlucose,
    required this.maxPreprandialGlucose,
    required this.minPostprandialGlucose,
    required this.maxPostprandialGlucose,
    required this.minPostExerciseGlucose,
    required this.maxPostExerciseGlucose,
    required this.states,
    required this.days,
  });

  factory ResponseBioReportGlucoseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportGlucoseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportGlucoseModelToJson(this);
}
