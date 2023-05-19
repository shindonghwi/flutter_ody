// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeInfoProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeInfoProfileModel _$ResponseMeInfoProfileModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMeInfoProfileModel(
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      diseases: (json['diseases'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$ResponseMeInfoProfileModelToJson(
        ResponseMeInfoProfileModel instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'gender': instance.gender,
      'diseases': instance.diseases,
      'height': instance.height,
      'weight': instance.weight,
    };
