import 'package:json_annotation/json_annotation.dart';

part 'ResponseDiseaseModel.g.dart';

@JsonSerializable()
class ResponseDiseaseModel {
  final String name;
  final String code;

  ResponseDiseaseModel({
    required this.name,
    required this.code,
  });

  factory ResponseDiseaseModel.fromJson(Map<String, dynamic> json) => _$ResponseDiseaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDiseaseModelToJson(this);
}