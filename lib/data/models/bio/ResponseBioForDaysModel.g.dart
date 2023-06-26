// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioForDaysModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioForDaysModel _$ResponseBioForDaysModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioForDaysModel(
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      bloodPressures: (json['bloodPressures'] as List<dynamic>)
          .map((e) =>
              ResponseBioBloodPressureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      glucoses: (json['glucoses'] as List<dynamic>)
          .map((e) =>
              ResponseBioGlucoseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseBioForDaysModelToJson(
        ResponseBioForDaysModel instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'bloodPressures': instance.bloodPressures,
      'glucoses': instance.glucoses,
    };
