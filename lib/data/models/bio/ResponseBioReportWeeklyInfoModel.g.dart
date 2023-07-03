// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportWeeklyInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportWeeklyInfoModel _$ResponseBioReportWeeklyInfoModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportWeeklyInfoModel(
      walking: ResponseBioReportWalkingModel.fromJson(
          json['walking'] as Map<String, dynamic>),
      bloodPressure: ResponseBioReportBloodPressureModel.fromJson(
          json['bloodPressure'] as Map<String, dynamic>),
      glucose: ResponseBioReportGlucoseModel.fromJson(
          json['glucose'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseBioReportWeeklyInfoModelToJson(
        ResponseBioReportWeeklyInfoModel instance) =>
    <String, dynamic>{
      'walking': instance.walking,
      'bloodPressure': instance.bloodPressure,
      'glucose': instance.glucose,
    };
