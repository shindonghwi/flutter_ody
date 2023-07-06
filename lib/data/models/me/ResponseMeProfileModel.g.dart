// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeProfileModel _$ResponseMeProfileModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMeProfileModel(
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      preventive: json['preventive'] == null
          ? null
          : ResponseMePreventiveModel.fromJson(
              json['preventive'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMeProfileModelToJson(
        ResponseMeProfileModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'birthday': instance.birthday,
      'height': instance.height,
      'weight': instance.weight,
      'preventive': instance.preventive,
    };
