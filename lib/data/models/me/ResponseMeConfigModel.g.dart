// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeConfigModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeConfigModel _$ResponseMeConfigModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMeConfigModel(
      notification: json['notification'] == null
          ? null
          : ResponseMeNotificationModel.fromJson(
              json['notification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMeConfigModelToJson(
        ResponseMeConfigModel instance) =>
    <String, dynamic>{
      'notification': instance.notification,
    };
