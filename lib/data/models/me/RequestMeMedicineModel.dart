import 'package:json_annotation/json_annotation.dart';
import 'package:odac_flutter_app/domain/models/me/YoilType.dart';

part 'RequestMeMedicineModel.g.dart';

@JsonSerializable()
class RequestMeMedicineModel {
  final String name;
  final String time;
  final List<YoilType> days;
  final bool enabled;

  RequestMeMedicineModel({
    required this.name,
    required this.time,
    required this.days,
    required this.enabled,
  });

  factory RequestMeMedicineModel.fromJson(Map<String, dynamic> json) =>
      _$RequestMeMedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMeMedicineModelToJson(this);
}
