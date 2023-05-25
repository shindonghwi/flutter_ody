// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestBioGlucoseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBioGlucoseModel _$RequestBioGlucoseModelFromJson(
        Map<String, dynamic> json) =>
    RequestBioGlucoseModel(
      time: json['time'] as String,
      type: json['type'] as String,
      glucose: json['glucose'] as int,
      memo: json['memo'] as String?,
      remindTime: json['remindTime'] as int?,
    );

Map<String, dynamic> _$RequestBioGlucoseModelToJson(
        RequestBioGlucoseModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'type': instance.type,
      'glucose': instance.glucose,
      'memo': instance.memo,
      'remindTime': instance.remindTime,
    };
