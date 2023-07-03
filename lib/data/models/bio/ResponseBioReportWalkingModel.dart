import 'package:json_annotation/json_annotation.dart';

part 'ResponseBioReportWalkingModel.g.dart';

@JsonSerializable()
class ResponseBioReportWalkingModel {
  final int totalSteps;
  final int totalCalories;
  final int beforeSteps;
  final int averageSteps;

  ResponseBioReportWalkingModel({
    required this.totalSteps,
    required this.totalCalories,
    required this.beforeSteps,
    required this.averageSteps,
  });

  factory ResponseBioReportWalkingModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportWalkingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportWalkingModelToJson(this);

}
