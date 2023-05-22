import 'package:json_annotation/json_annotation.dart';

part 'RequestBioStepsModel.g.dart';

@JsonSerializable()
class RequestBioStepsModel {
  final String time;
  final int count;

  RequestBioStepsModel({
    required this.time,
    required this.count,
  });

  factory RequestBioStepsModel.fromJson(Map<String, dynamic> json) => _$RequestBioStepsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBioStepsModelToJson(this);
}