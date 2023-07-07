import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWeeksModel.dart';

part 'ResponseBioReportWalkingModel.g.dart';

@JsonSerializable()
class ResponseBioReportWalkingModel {
  final int totalSteps;
  final int totalCalories;
  final int beforeSteps;
  final int averageSteps;
  List<ResponseBioReportDaysModel>? days;
  List<ResponseBioReportWeeksModel>? weeks;

  ResponseBioReportWalkingModel({
    this.totalSteps = 0,
    this.totalCalories = 0,
    this.beforeSteps = 0,
    this.averageSteps = 0,
    this.days,
    this.weeks,
  });

  factory ResponseBioReportWalkingModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportWalkingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportWalkingModelToJson(this);
}
