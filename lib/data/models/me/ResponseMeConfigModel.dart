import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeNotificationModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseMeConfigModel.g.dart';

@JsonSerializable()
class ResponseMeConfigModel {
  final ResponseMeNotificationModel? notification;

  ResponseMeConfigModel({
    required this.notification,
  });

  factory ResponseMeConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeConfigModelToJson(this);

  ResponseMeConfigModel copyWith({
    ResponseMeNotificationModel? notification,
  }) {
    return ResponseMeConfigModel(
      notification: notification ?? this.notification,
    );
  }

}
