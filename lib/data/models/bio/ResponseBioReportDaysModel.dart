import 'package:json_annotation/json_annotation.dart';

part 'ResponseBioReportDaysModel.g.dart';

@JsonSerializable()
class ResponseBioReportDaysModel {
  final String? day;
  final int? steps;
  final int? systolic;
  final int? diastolic;
  final int? heartRate;
  final int? glucose;
  final String? state;

  ResponseBioReportDaysModel({
    required this.day,
    required this.steps,
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
    required this.glucose,
    required this.state,
  });

  factory ResponseBioReportDaysModel.fromJson(Map<String, dynamic> json) => _$ResponseBioReportDaysModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportDaysModelToJson(this);
}
