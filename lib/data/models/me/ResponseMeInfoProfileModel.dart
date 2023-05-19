import 'package:json_annotation/json_annotation.dart';

part 'ResponseMeInfoProfileModel.g.dart';

@JsonSerializable()
class ResponseMeInfoProfileModel {
  final String? gender;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? diseases;

  ResponseMeInfoProfileModel({
    required this.gender,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.diseases,
  });

  factory ResponseMeInfoProfileModel.fromJson(Map<String, dynamic> json) => _$ResponseMeInfoProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoProfileModelToJson(this);
}