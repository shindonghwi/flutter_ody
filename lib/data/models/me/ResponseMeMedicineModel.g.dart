// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeMedicineModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeMedicineModel _$ResponseMeMedicineModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMeMedicineModel(
      medicineSeq: json['medicineSeq'] as int?,
      name: json['name'] as String?,
      days: (json['days'] as List<dynamic>?)?.map((e) => e as String).toList(),
      time: json['time'] as String,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$ResponseMeMedicineModelToJson(
        ResponseMeMedicineModel instance) =>
    <String, dynamic>{
      'medicineSeq': instance.medicineSeq,
      'name': instance.name,
      'days': instance.days,
      'time': instance.time,
      'enabled': instance.enabled,
    };
