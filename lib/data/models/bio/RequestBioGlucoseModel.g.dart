// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestBioGlucoseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBioGlucoseModel _$RequestBioGlucoseModelFromJson(
        Map<String, dynamic> json) =>
    RequestBioGlucoseModel(
      time: json['time'] as String,
      type: $enumDecode(_$GlucoseMeasureTypeEnumMap, json['type']),
      glucose: json['glucose'] as int,
      memo: json['memo'] as String?,
      remindTime: json['remindTime'] as String?,
    );

Map<String, dynamic> _$RequestBioGlucoseModelToJson(
        RequestBioGlucoseModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'type': _$GlucoseMeasureTypeEnumMap[instance.type]!,
      'glucose': instance.glucose,
      'memo': instance.memo,
      'remindTime': instance.remindTime,
    };

const _$GlucoseMeasureTypeEnumMap = {
  GlucoseMeasureType.Fasting: 'Fasting',
  GlucoseMeasureType.BeforeMeal: 'BeforeMeal',
  GlucoseMeasureType.AfterMeals: 'AfterMeals',
  GlucoseMeasureType.PostWorkout: 'PostWorkout',
};
