import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWalkingModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';

part 'ResponseBioReportWeeklyInfoModel.g.dart';

@JsonSerializable()
class ResponseBioReportWeeklyInfoModel {
  final ResponseBioReportWalkingModel walking;
  final ResponseBioReportBloodPressureModel bloodPressure;
  final ResponseBioReportGlucoseModel glucose;

  ResponseBioReportWeeklyInfoModel({
    required this.walking,
    required this.bloodPressure,
    required this.glucose,
  });

  factory ResponseBioReportWeeklyInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportWeeklyInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportWeeklyInfoModelToJson(this);

}
