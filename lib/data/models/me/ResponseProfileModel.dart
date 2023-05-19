import 'package:json_annotation/json_annotation.dart';
import 'package:odac_flutter_app/data/models/me/ResponsePreventiveModel.dart';

part 'ResponseProfileModel.g.dart';

@JsonSerializable()
class ResponseProfileModel {
  final String? gender;
  final String? birthday;
  final int? height;
  final int? weight;
  final ResponsePreventiveModel? preventive;

  ResponseProfileModel({
    required this.gender,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.preventive,
  });

  factory ResponseProfileModel.fromJson(Map<String, dynamic> json) => _$ResponseProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProfileModelToJson(this);
}