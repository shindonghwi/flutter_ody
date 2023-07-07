// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestMeMedicineUpdateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMeMedicineUpdateModel _$RequestMeMedicineUpdateModelFromJson(
        Map<String, dynamic> json) =>
    RequestMeMedicineUpdateModel(
      medicineSeq: json['medicineSeq'] as int,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$RequestMeMedicineUpdateModelToJson(
        RequestMeMedicineUpdateModel instance) =>
    <String, dynamic>{
      'medicineSeq': instance.medicineSeq,
      'enabled': instance.enabled,
    };
