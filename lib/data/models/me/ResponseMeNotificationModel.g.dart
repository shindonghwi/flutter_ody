// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeNotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeNotificationModel _$ResponseMeNotificationModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMeNotificationModel(
      all: json['all'] as bool,
      medicine: json['medicine'] as bool,
      step: json['step'] as bool,
      bloodPressure: json['bloodPressure'] as bool,
      glucose: json['glucose'] as bool,
      report: json['report'] as bool,
    );

Map<String, dynamic> _$ResponseMeNotificationModelToJson(
        ResponseMeNotificationModel instance) =>
    <String, dynamic>{
      'all': instance.all,
      'medicine': instance.medicine,
      'step': instance.step,
      'bloodPressure': instance.bloodPressure,
      'glucose': instance.glucose,
      'report': instance.report,
    };
