import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMePreventiveModel.dart';

part 'ResponseMeProfileModel.g.dart';

@JsonSerializable()
class ResponseMeProfileModel {
  final String? gender;
  final String? birthday;
  final int? height;
  final int? weight;
  final ResponseMePreventiveModel? preventive;

  ResponseMeProfileModel({
    required this.gender,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.preventive,
  });

  factory ResponseMeProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeProfileModelToJson(this);

  ResponseMeProfileModel copyWith({
    final String? gender,
    final String? birthday,
    final int? height,
    final int? weight,
    final ResponseMePreventiveModel? preventive,
  }) {
    return ResponseMeProfileModel(
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        preventive: preventive ?? this.preventive,
    );
  }
}