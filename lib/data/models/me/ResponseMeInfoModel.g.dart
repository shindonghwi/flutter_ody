// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeInfoModel _$ResponseMeInfoModelFromJson(Map<String, dynamic> json) =>
    ResponseMeInfoModel(
      email: json['email'] as String,
      nick: json['nick'] as String,
      profile: ResponseProfileModel.fromJson(
          json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMeInfoModelToJson(
        ResponseMeInfoModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nick': instance.nick,
      'profile': instance.profile,
    };
