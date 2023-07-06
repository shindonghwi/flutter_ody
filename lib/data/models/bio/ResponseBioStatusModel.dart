import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseBioStatusModel.g.dart';

@JsonSerializable()
class ResponseBioStatusModel {
  final String code;
  final String name;

  ResponseBioStatusModel({
    required this.code,
    required this.name,
  });

  factory ResponseBioStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioStatusModelToJson(this);
}
