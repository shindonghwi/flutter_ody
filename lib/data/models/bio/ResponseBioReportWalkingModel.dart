import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';

part 'ResponseBioReportWalkingModel.g.dart';

@JsonSerializable()
class ResponseBioReportWalkingModel {
  final int totalSteps;
  final int totalCalories;
  final int beforeSteps;
  final int averageSteps;
  final List<ResponseBioReportDaysModel> days;

  ResponseBioReportWalkingModel({
    required this.totalSteps,
    required this.totalCalories,
    required this.beforeSteps,
    required this.averageSteps,
    required this.days,
  });

  factory ResponseBioReportWalkingModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportWalkingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportWalkingModelToJson(this);

}
