import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportStatesModel.dart';

part 'ResponseBioReportBloodPressureModel.g.dart';

@JsonSerializable()
class ResponseBioReportBloodPressureModel {
  final int totalCount;
  final int averageSystolic;
  final int averageDiastolic;
  final int averageHeartRate;
  final List<ResponseBioReportStatesModel> states;
  final List<ResponseBioReportDaysModel> days;

  ResponseBioReportBloodPressureModel({
    required this.totalCount,
    required this.averageSystolic,
    required this.averageDiastolic,
    required this.averageHeartRate,
    required this.states,
    required this.days,
  });

  factory ResponseBioReportBloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportBloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportBloodPressureModelToJson(this);
}
