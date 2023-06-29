// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBioReportListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBioReportListModel _$ResponseBioReportListModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBioReportListModel(
      reportSeq: json['reportSeq'] as int,
      year: json['year'] as int,
      month: json['month'] as int,
      minDate: json['minDate'] as String,
      maxDate: json['maxDate'] as String,
    );

Map<String, dynamic> _$ResponseBioReportListModelToJson(
        ResponseBioReportListModel instance) =>
    <String, dynamic>{
      'reportSeq': instance.reportSeq,
      'year': instance.year,
      'month': instance.month,
      'minDate': instance.minDate,
      'maxDate': instance.maxDate,
    };
