import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseProfileModel.dart';

part 'ResponseBioBloodPressureModel.g.dart';

@JsonSerializable()
class ResponseBioBloodPressureModel {
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final int heartRate;
  final ResponseBioStatusModel status;
  final String createdAt;

  ResponseBioBloodPressureModel({
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
    required this.heartRate,
    required this.status,
    required this.createdAt,
  });

  factory ResponseBioBloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioBloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioBloodPressureModelToJson(this);
}
