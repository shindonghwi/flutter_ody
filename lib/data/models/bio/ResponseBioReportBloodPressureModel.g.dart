// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportBloodPressureModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportBloodPressureModel
    _$ResponseBioReportBloodPressureModelFromJson(Map<String, dynamic> json) =>
        ResponseBioReportBloodPressureModel(
          totalCount: json['totalCount'] as int? ?? 0,
          averageSystolic: json['averageSystolic'] as int? ?? 0,
          averageDiastolic: json['averageDiastolic'] as int? ?? 0,
          averageHeartRate: json['averageHeartRate'] as int? ?? 0,
          states: (json['states'] as List<dynamic>?)
              ?.map((e) => ResponseBioReportStatesModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          days: (json['days'] as List<dynamic>?)
              ?.map((e) => ResponseBioReportDaysModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          weeks: (json['weeks'] as List<dynamic>?)
              ?.map((e) => ResponseBioReportWeeksModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$ResponseBioReportBloodPressureModelToJson(
        ResponseBioReportBloodPressureModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'averageSystolic': instance.averageSystolic,
      'averageDiastolic': instance.averageDiastolic,
      'averageHeartRate': instance.averageHeartRate,
      'states': instance.states,
      'days': instance.days,
      'weeks': instance.weeks,
    };
