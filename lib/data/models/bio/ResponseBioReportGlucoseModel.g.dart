// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportGlucoseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportGlucoseModel _$ResponseBioReportGlucoseModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportGlucoseModel(
      totalCount: json['totalCount'] as int? ?? 0,
      minFastingGlucose: json['minFastingGlucose'] as int? ?? 0,
      maxFastingGlucose: json['maxFastingGlucose'] as int? ?? 0,
      minPreprandialGlucose: json['minPreprandialGlucose'] as int? ?? 0,
      maxPreprandialGlucose: json['maxPreprandialGlucose'] as int? ?? 0,
      minPostprandialGlucose: json['minPostprandialGlucose'] as int? ?? 0,
      maxPostprandialGlucose: json['maxPostprandialGlucose'] as int? ?? 0,
      minPostExerciseGlucose: json['minPostExerciseGlucose'] as int? ?? 0,
      maxPostExerciseGlucose: json['maxPostExerciseGlucose'] as int? ?? 0,
      states: (json['states'] as List<dynamic>?)
          ?.map((e) =>
              ResponseBioReportStatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>?)
          ?.map((e) =>
              ResponseBioReportDaysModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeks: (json['weeks'] as List<dynamic>?)
          ?.map((e) =>
              ResponseBioReportWeeksModel.fromJson(e as Map<String, dynamic>))
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
      'weeks': instance.weeks,
    };
