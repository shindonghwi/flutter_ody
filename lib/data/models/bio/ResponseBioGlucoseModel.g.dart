// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioGlucoseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioGlucoseModel _$ResponseBioGlucoseModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioGlucoseModel(
      type: ResponseBioGlucoseTypeModel.fromJson(
          json['type'] as Map<String, dynamic>),
      glucose: json['glucose'] as int,
      status: ResponseBioStatusModel.fromJson(
          json['status'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ResponseBioGlucoseModelToJson(
        ResponseBioGlucoseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'glucose': instance.glucose,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
