import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseBioGlucoseTypeModel.g.dart';

@JsonSerializable()
class ResponseBioGlucoseTypeModel {
  final String code;
  final String name;

  ResponseBioGlucoseTypeModel({
    required this.code,
    required this.name,
  });

  factory ResponseBioGlucoseTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioGlucoseTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioGlucoseTypeModelToJson(this);
}
