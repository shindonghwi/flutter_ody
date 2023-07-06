import 'package:json_annotation/json_annotation.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeConfigModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';

part 'ResponseMeInfoModel.g.dart';

@JsonSerializable()
class ResponseMeInfoModel {
  final String? email;
  final String? nick;
  final ResponseMeProfileModel? profile;
  final ResponseMeConfigModel? config;

  ResponseMeInfoModel({
    required this.email,
    required this.nick,
    required this.profile,
    required this.config,
  });

  factory ResponseMeInfoModel.fromJson(Map<String, dynamic> json) => _$ResponseMeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoModelToJson(this);

  ResponseMeInfoModel copyWith({
    String? email,
    String? nick,
    ResponseMeProfileModel? profile,
    ResponseMeConfigModel? config,
  }) {
    return ResponseMeInfoModel(
      email: email ?? this.email,
      nick: nick ?? this.nick,
      profile: profile ?? this.profile,
      config: config ?? this.config,
    );
  }
}
