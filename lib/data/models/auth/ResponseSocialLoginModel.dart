import 'package:json_annotation/json_annotation.dart';

part 'ResponseSocialLoginModel.g.dart';

@JsonSerializable()
class ResponseSocialLoginModel {
  final String accessToken;

  ResponseSocialLoginModel({
    required this.accessToken,
  });

  factory ResponseSocialLoginModel.fromJson(Map<String, dynamic> json) => _$ResponseSocialLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSocialLoginModelToJson(this);
}