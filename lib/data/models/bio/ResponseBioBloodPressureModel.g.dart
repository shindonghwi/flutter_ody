// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioBloodPressureModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioBloodPressureModel _$ResponseBioBloodPressureModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioBloodPressureModel(
      systolicBloodPressure: json['systolicBloodPressure'] as int,
      diastolicBloodPressure: json['diastolicBloodPressure'] as int,
      heartRate: json['heartRate'] as int,
      status: ResponseBioStatusModel.fromJson(
          json['status'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ResponseBioBloodPressureModelToJson(
        ResponseBioBloodPressureModel instance) =>
    <String, dynamic>{
      'systolicBloodPressure': instance.systolicBloodPressure,
      'diastolicBloodPressure': instance.diastolicBloodPressure,
      'heartRate': instance.heartRate,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
