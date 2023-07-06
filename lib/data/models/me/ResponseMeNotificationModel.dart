import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseMeNotificationModel.g.dart';

@JsonSerializable()
class ResponseMeNotificationModel {
  final bool all;
  final bool medicine;
  final bool step;
  final bool bloodPressure;
  final bool glucose;
  final bool report;

  ResponseMeNotificationModel({
    required this.all,
    required this.medicine,
    required this.step,
    required this.bloodPressure,
    required this.glucose,
    required this.report,
  });

  factory ResponseMeNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeNotificationModelToJson(this);
}
