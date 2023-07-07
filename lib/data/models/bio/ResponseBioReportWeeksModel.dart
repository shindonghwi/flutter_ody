import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';

part 'ResponseBioReportWeeksModel.g.dart';

@JsonSerializable()
class ResponseBioReportWeeksModel {
  final int? numberOfWeeks;
  final int? steps;
  final int? systolic;
  final int? diastolic;
  final int? heartRate;
  final List<ResponseBioReportDaysModel>? days;

  ResponseBioReportWeeksModel({
    required this.numberOfWeeks,
    required this.steps,
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
    required this.days,
  });

  factory ResponseBioReportWeeksModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportWeeksModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportWeeksModelToJson(this);

}
