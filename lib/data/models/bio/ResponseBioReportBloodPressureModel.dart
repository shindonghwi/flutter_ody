import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportStatesModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWeeksModel.dart';

part 'ResponseBioReportBloodPressureModel.g.dart';

@JsonSerializable()
class ResponseBioReportBloodPressureModel {
  final int totalCount;
  final int averageSystolic;
  final int averageDiastolic;
  final int averageHeartRate;
  final List<ResponseBioReportStatesModel>? states;
  final List<ResponseBioReportDaysModel>? days;
  final List<ResponseBioReportWeeksModel>? weeks;

  ResponseBioReportBloodPressureModel({
    this.totalCount = 0,
    this.averageSystolic = 0,
    this.averageDiastolic = 0,
    this.averageHeartRate = 0,
    this.states,
    this.days,
    this.weeks,
  });

  factory ResponseBioReportBloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportBloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportBloodPressureModelToJson(this);
}
