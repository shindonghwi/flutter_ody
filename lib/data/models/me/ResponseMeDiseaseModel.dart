import 'package:json_annotation/json_annotation.dart';

part 'ResponseMeDiseaseModel.g.dart';

@JsonSerializable()
class ResponseMeDiseaseModel {
  final String name;
  final String code;

  ResponseMeDiseaseModel({
    required this.name,
    required this.code,
  });

  factory ResponseMeDiseaseModel.fromJson(Map<String, dynamic> json) => _$ResponseMeDiseaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeDiseaseModelToJson(this);
}