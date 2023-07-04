import 'package:json_annotation/json_annotation.dart';

part 'ResponseBioReportStatesModel.g.dart';

@JsonSerializable()
class ResponseBioReportStatesModel {
  final String? state;
  final int? count;

  ResponseBioReportStatesModel({
    required this.state,
    required this.count,
  });

  factory ResponseBioReportStatesModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBioReportStatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBioReportStatesModelToJson(this);

}
