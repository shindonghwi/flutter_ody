import 'package:json_annotation/json_annotation.dart';
import 'package:odac_flutter_app/domain/models/bio/GlucoseMesaureType.dart';

part 'RequestBioGlucoseModel.g.dart';

@JsonSerializable()
class RequestBioGlucoseModel {
  final String time;
  final GlucoseMeasureType type;
  final int glucose;
  final String? memo;
  final String? remindTime;

  RequestBioGlucoseModel({
    required this.time,
    required this.type,
    required this.glucose,
    required this.memo,
    required this.remindTime,
  });

  factory RequestBioGlucoseModel.fromJson(Map<String, dynamic> json) => _$RequestBioGlucoseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBioGlucoseModelToJson(this);
}