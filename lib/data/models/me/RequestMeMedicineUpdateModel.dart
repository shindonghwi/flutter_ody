import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/domain/models/me/YoilType.dart';

part 'RequestMeMedicineUpdateModel.g.dart';

@JsonSerializable()
class RequestMeMedicineUpdateModel {
  final int medicineSeq;
  final bool enabled;

  RequestMeMedicineUpdateModel({
    required this.medicineSeq,
    required this.enabled,
  });

  factory RequestMeMedicineUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$RequestMeMedicineUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMeMedicineUpdateModelToJson(this);
}
