import 'package:json_annotation/json_annotation.dart';

part 'RequestBioBloodPressureModel.g.dart';

@JsonSerializable()
class RequestBioBloodPressureModel {
  final String time;
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final int heartRate;

  RequestBioBloodPressureModel({
    required this.time,
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
    required this.heartRate,
  });

  factory RequestBioBloodPressureModel.fromJson(Map<String, dynamic> json) => _$RequestBioBloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBioBloodPressureModelToJson(this);
}