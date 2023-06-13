import 'package:json_annotation/json_annotation.dart';
import 'package:odac_flutter_app/data/models/me/ResponseDiseaseModel.dart';

part 'ResponsePreventiveModel.g.dart';

@JsonSerializable()
class ResponsePreventiveModel {
  final List<ResponseDiseaseModel>? diseases;

  ResponsePreventiveModel({
    required this.diseases,
  });

  factory ResponsePreventiveModel.fromJson(Map<String, dynamic> json) =>
      _$ResponsePreventiveModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePreventiveModelToJson(this);

  ResponsePreventiveModel copyWith({
    final List<ResponseDiseaseModel>? diseases,
  }) {
    return ResponsePreventiveModel(
      diseases: diseases ?? this.diseases,
    );
  }
}
