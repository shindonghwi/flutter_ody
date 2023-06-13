// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileModel _$ResponseProfileModelFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileModel(
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      preventive: json['preventive'] == null
          ? null
          : ResponsePreventiveModel.fromJson(
              json['preventive'] as Map<String, dynamic>),
      social: json['social'] == null
          ? null
          : ResponseSocialModel.fromJson(
              json['social'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileModelToJson(
        ResponseProfileModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'birthday': instance.birthday,
      'height': instance.height,
      'weight': instance.weight,
      'preventive': instance.preventive,
      'social': instance.social,
    };
