// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportWalkingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportWalkingModel _$ResponseBioReportWalkingModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportWalkingModel(
      totalSteps: json['totalSteps'] as int,
      totalCalories: json['totalCalories'] as int,
      beforeSteps: json['beforeSteps'] as int,
      averageSteps: json['averageSteps'] as int,
      days: (json['days'] as List<dynamic>)
          .map((e) =>
              ResponseBioReportDaysModel.fromJson(e as Map<String, dynamic>))
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
    };
