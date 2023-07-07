// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestMeMedicineModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMeMedicineModel _$RequestMeMedicineModelFromJson(
        Map<String, dynamic> json) =>
    RequestMeMedicineModel(
      name: json['name'] as String,
      time: json['time'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => $enumDecode(_$YoilTypeEnumMap, e))
          .toList(),
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$RequestMeMedicineModelToJson(
        RequestMeMedicineModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'time': instance.time,
      'days': instance.days.map((e) => _$YoilTypeEnumMap[e]!).toList(),
      'enabled': instance.enabled,
    };

const _$YoilTypeEnumMap = {
  YoilType.MONDAY: 'MONDAY',
  YoilType.TUESDAY: 'TUESDAY',
  YoilType.WEDNESDAY: 'WEDNESDAY',
  YoilType.THURSDAY: 'THURSDAY',
  YoilType.FRIDAY: 'FRIDAY',
  YoilType.SATURDAY: 'SATURDAY',
  YoilType.SUNDAY: 'SUNDAY',
};
