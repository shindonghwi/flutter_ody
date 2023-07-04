// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportInfoModel _$ResponseBioReportInfoModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportInfoModel(
      walking: ResponseBioReportWalkingModel.fromJson(
          json['walking'] as Map<String, dynamic>),
      bloodPressure: ResponseBioReportBloodPressureModel.fromJson(
          json['bloodPressure'] as Map<String, dynamic>),
      glucose: ResponseBioReportGlucoseModel.fromJson(
          json['glucose'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseBioReportInfoModelToJson(
        ResponseBioReportInfoModel instance) =>
    <String, dynamic>{
      'walking': instance.walking,
      'bloodPressure': instance.bloodPressure,
      'glucose': instance.glucose,
    };
