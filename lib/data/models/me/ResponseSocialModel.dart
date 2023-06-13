import 'package:json_annotation/json_annotation.dart';
import 'package:odac_flutter_app/data/models/me/ResponseDiseaseModel.dart';

part 'ResponseSocialModel.g.dart';

@JsonSerializable()
class ResponseSocialModel {
  final String type;

  ResponseSocialModel({
    required this.type,
  });

  factory ResponseSocialModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseSocialModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSocialModelToJson(this);

  ResponseSocialModel copyWith({
    final String? type,
  }) {
    return ResponseSocialModel(
      type: type ?? this.type,
    );
  }
}
