// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportGlucoseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportGlucoseModel _$ResponseBioReportGlucoseModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportGlucoseModel(
      totalCount: json['totalCount'] as int,
      minFastingGlucose: json['minFastingGlucose'] as int,
      maxFastingGlucose: json['maxFastingGlucose'] as int,
      minPreprandialGlucose: json['minPreprandialGlucose'] as int,
      maxPreprandialGlucose: json['maxPreprandialGlucose'] as int,
      minPostprandialGlucose: json['minPostprandialGlucose'] as int,
      maxPostprandialGlucose: json['maxPostprandialGlucose'] as int,
      minPostExerciseGlucose: json['minPostExerciseGlucose'] as int,
      maxPostExerciseGlucose: json['maxPostExerciseGlucose'] as int,
      states: (json['states'] as List<dynamic>)
          .map((e) =>
              ResponseBioReportStatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>)
          .map((e) =>
              ResponseBioReportDaysModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseBioReportGlucoseModelToJson(
        ResponseBioReportGlucoseModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'minFastingGlucose': instance.minFastingGlucose,
      'maxFastingGlucose': instance.maxFastingGlucose,
      'minPreprandialGlucose': instance.minPreprandialGlucose,
      'maxPreprandialGlucose': instance.maxPreprandialGlucose,
      'minPostprandialGlucose': instance.minPostprandialGlucose,
      'maxPostprandialGlucose': instance.maxPostprandialGlucose,
      'minPostExerciseGlucose': instance.minPostExerciseGlucose,
      'maxPostExerciseGlucose': instance.maxPostExerciseGlucose,
      'states': instance.states,
      'days': instance.days,
    };
