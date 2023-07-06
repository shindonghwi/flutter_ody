import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseTypeModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseBioGlucoseModel.g.dart';

@JsonSerializable()
class ResponseBioGlucoseModel {
  final ResponseBioGlucoseTypeModel type;
  final int glucose;
  final ResponseBioStatusModel status;
  final String createdAt;

  ResponseBioGlucoseModel({
    required this.type,
    required this.glucose,
    required this.status,
    required this.createdAt,
  });

  factory ResponseBioGlucoseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioGlucoseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioGlucoseModelToJson(this);
}
