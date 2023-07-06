import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStepModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseBioForDaysModel.g.dart';

@JsonSerializable()
class ResponseBioForDaysModel {
  final List<ResponseBioStepModel> steps;
  final List<ResponseBioBloodPressureModel> bloodPressures;
  final List<ResponseBioGlucoseModel> glucoses;

  ResponseBioForDaysModel({
    required this.steps,
    required this.bloodPressures,
    required this.glucoses,
  });

  factory ResponseBioForDaysModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioForDaysModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioForDaysModelToJson(this);

  ResponseBioForDaysModel copyWith({
    List<ResponseBioStepModel>? steps,
    List<ResponseBioBloodPressureModel>? bloodPressures,
    List<ResponseBioGlucoseModel>? glucoses,
  }) {
    return ResponseBioForDaysModel(
        steps: steps ?? this.steps,
        bloodPressures: bloodPressures ?? this.bloodPressures,
        glucoses: glucoses ?? this.glucoses
    );
  }
}
