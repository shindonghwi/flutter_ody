import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWalkingModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';

part 'ResponseBioReportInfoModel.g.dart';

@JsonSerializable()
class ResponseBioReportInfoModel {
  final ResponseBioReportWalkingModel walking;
  final ResponseBioReportBloodPressureModel bloodPressure;
  final ResponseBioReportGlucoseModel glucose;

  ResponseBioReportInfoModel({
    required this.walking,
    required this.bloodPressure,
    required this.glucose,
  });

  factory ResponseBioReportInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportInfoModelToJson(this);

}
