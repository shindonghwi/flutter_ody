// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMePreventiveModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMePreventiveModel _$ResponseMePreventiveModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMePreventiveModel(
      diseases: (json['diseases'] as List<dynamic>?)
          ?.map(
              (e) => ResponseMeDiseaseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseMePreventiveModelToJson(
        ResponseMePreventiveModel instance) =>
    <String, dynamic>{
      'diseases': instance.diseases,
    };
