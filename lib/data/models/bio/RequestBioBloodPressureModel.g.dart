// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestBioBloodPressureModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBioBloodPressureModel _$RequestBioBloodPressureModelFromJson(
        Map<String, dynamic> json) =>
    RequestBioBloodPressureModel(
      time: json['time'] as String,
      systolicBloodPressure: json['systolicBloodPressure'] as int,
      diastolicBloodPressure: json['diastolicBloodPressure'] as int,
      heartRate: json['heartRate'] as int,
    );

Map<String, dynamic> _$RequestBioBloodPressureModelToJson(
        RequestBioBloodPressureModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'systolicBloodPressure': instance.systolicBloodPressure,
      'diastolicBloodPressure': instance.diastolicBloodPressure,
      'heartRate': instance.heartRate,
    };
