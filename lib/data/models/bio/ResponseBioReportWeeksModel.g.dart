// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportWeeksModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportWeeksModel _$ResponseBioReportWeeksModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportWeeksModel(
      numberOfWeeks: json['numberOfWeeks'] as int?,
      steps: json['steps'] as int?,
      systolic: json['systolic'] as int?,
      diastolic: json['diastolic'] as int?,
      heartRate: json['heartRate'] as int?,
      days: (json['days'] as List<dynamic>?)
          ?.map((e) =>
              ResponseBioReportDaysModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseBioReportWeeksModelToJson(
        ResponseBioReportWeeksModel instance) =>
    <String, dynamic>{
      'numberOfWeeks': instance.numberOfWeeks,
      'steps': instance.steps,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'heartRate': instance.heartRate,
      'days': instance.days,
    };
