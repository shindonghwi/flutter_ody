import 'package:json_annotation/json_annotation.dart';

part 'ResponseBioStepModel.g.dart';

@JsonSerializable()
class ResponseBioStepModel {
  final int count;
  final String createdAt;

  ResponseBioStepModel({
    required this.count,
    required this.createdAt,
  });

  factory ResponseBioStepModel.fromJson(Map<String, dynamic> json) => _$ResponseBioStepModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioStepModelToJson(this);
}
