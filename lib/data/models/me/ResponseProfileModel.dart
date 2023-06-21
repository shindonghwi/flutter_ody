import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponsePreventiveModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseSocialModel.dart';

part 'ResponseProfileModel.g.dart';

@JsonSerializable()
class ResponseProfileModel {
  final String? gender;
  final String? birthday;
  final int? height;
  final int? weight;
  final ResponsePreventiveModel? preventive;
  final ResponseSocialModel? social;

  ResponseProfileModel({
    required this.gender,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.preventive,
    required this.social,
  });

  factory ResponseProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProfileModelToJson(this);

  ResponseProfileModel copyWith({
    final String? gender,
    final String? birthday,
    final int? height,
    final int? weight,
    final ResponsePreventiveModel? preventive,
    final ResponseSocialModel? social,
  }) {
    return ResponseProfileModel(
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        preventive: preventive ?? this.preventive,
        social: social ?? this.social
    );
  }
}