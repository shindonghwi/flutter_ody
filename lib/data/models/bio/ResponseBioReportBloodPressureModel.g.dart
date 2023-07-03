// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportBloodPressureModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportBloodPressureModel
    _$ResponseBioReportBloodPressureModelFromJson(Map<String, dynamic> json) =>
        ResponseBioReportBloodPressureModel(
          totalCount: json['totalCount'] as int,
          averageSystolic: json['averageSystolic'] as int,
          averageDiastolic: json['averageDiastolic'] as int,
          averageHeartRate: json['averageHeartRate'] as int,
          states: (json['states'] as List<dynamic>)
              .map((e) => ResponseBioReportStatesModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          days: (json['days'] as List<dynamic>)
              .map((e) => ResponseBioReportDaysModel.fromJson(
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
    };
