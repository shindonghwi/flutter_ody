import 'package:json_annotation/json_annotation.dart';

part 'ResponseMeMedicineModel.g.dart';

@JsonSerializable()
class ResponseMeMedicineModel {
  final int? medicineSeq;
  final String? name;
  final List<String>? days;
  final String time;
  final bool enabled;

  ResponseMeMedicineModel({
    required this.medicineSeq,
    required this.name,
    required this.days,
    required this.time,
    required this.enabled,
  });

  factory ResponseMeMedicineModel.fromJson(Map<String, dynamic> json) => _$ResponseMeMedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeMedicineModelToJson(this);

  ResponseMeMedicineModel copyWith({
    int? medicineSeq,
    String? name,
    List<String>? days,
    String? time,
    bool? enabled,
  }) {
    return ResponseMeMedicineModel(
      medicineSeq: medicineSeq ?? this.medicineSeq,
      name: name ?? this.name,
      days: days ?? this.days,
      time: time ?? this.time,
      enabled: enabled ?? this.enabled,
    );
  }
}
