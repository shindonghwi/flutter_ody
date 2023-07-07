import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeDiseaseModel.dart';

part 'ResponseMePreventiveModel.g.dart';

@JsonSerializable()
class ResponseMePreventiveModel {
  final List<ResponseMeDiseaseModel>? diseases;

  ResponseMePreventiveModel({
    required this.diseases,
  });

  factory ResponseMePreventiveModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseMePreventiveModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMePreventiveModelToJson(this);

  ResponseMePreventiveModel copyWith({
    final List<ResponseMeDiseaseModel>? diseases,
  }) {
    return ResponseMePreventiveModel(
      diseases: diseases ?? this.diseases,
    );
  }
}
