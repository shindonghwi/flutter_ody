import 'package:json_annotation/json_annotation.dart';

part 'ResponseBioReportListModel.g.dart';

@JsonSerializable()
class ResponseBioReportListModel {
  final int reportSeq;
  final int year;
  final int month;
  final String minDate;
  final String maxDate;

  ResponseBioReportListModel({
    required this.reportSeq,
    required this.year,
    required this.month,
    required this.minDate,
    required this.maxDate,
  });

  factory ResponseBioReportListModel.fromJson(Map<String, dynamic> json) => _$ResponseBioReportListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportListModelToJson(this);
}
