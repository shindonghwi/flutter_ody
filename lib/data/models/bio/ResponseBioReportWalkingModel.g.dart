// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportWalkingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportWalkingModel _$ResponseBioReportWalkingModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportWalkingModel(
      totalSteps: json['totalSteps'] as int? ?? 0,
      totalCalories: json['totalCalories'] as int? ?? 0,
      beforeSteps: json['beforeSteps'] as int? ?? 0,
      averageSteps: json['averageSteps'] as int? ?? 0,
      days: (json['days'] as List<dynamic>?)
          ?.map((e) =>
              ResponseBioReportDaysModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeks: (json['weeks'] as List<dynamic>?)
          ?.map((e) =>
              ResponseBioReportWeeksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseBioReportWalkingModelToJson(
        ResponseBioReportWalkingModel instance) =>
    <String, dynamic>{
      'totalSteps': instance.totalSteps,
      'totalCalories': instance.totalCalories,
      'beforeSteps': instance.beforeSteps,
      'averageSteps': instance.averageSteps,
      'days': instance.days,
      'weeks': instance.weeks,
    };
