import 'package:json_annotation/json_annotation.dart';

part 'ResponseMeInfoProfileModel.g.dart';

@JsonSerializable()
class ResponseMeInfoProfileModel {
  final double height;
  final double weight;

  ResponseMeInfoProfileModel({
    required this.height,
    required this.weight,
  });

  factory ResponseMeInfoProfileModel.fromJson(Map<String, dynamic> json) => _$ResponseMeInfoProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoProfileModelToJson(this);
}