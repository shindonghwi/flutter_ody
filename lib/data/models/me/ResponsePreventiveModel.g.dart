// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePreventiveModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePreventiveModel _$ResponsePreventiveModelFromJson(
        Map<String, dynamic> json) =>
    ResponsePreventiveModel(
      diseases: (json['diseases'] as List<dynamic>?)
          ?.map((e) => ResponseDiseaseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponsePreventiveModelToJson(
        ResponsePreventiveModel instance) =>
    <String, dynamic>{
      'diseases': instance.diseases,
    };
