// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportDaysModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportDaysModel _$ResponseBioReportDaysModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportDaysModel(
      day: json['day'] as String?,
      steps: json['steps'] as int?,
      systolic: json['systolic'] as int?,
      diastolic: json['diastolic'] as int?,
      heartRate: json['heartRate'] as int?,
      glucose: json['glucose'] as int?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$ResponseBioReportDaysModelToJson(
        ResponseBioReportDaysModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'steps': instance.steps,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'heartRate': instance.heartRate,
      'glucose': instance.glucose,
      'state': instance.state,
    };
