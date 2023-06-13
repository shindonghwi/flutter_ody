import 'package:json_annotation/json_annotation.dart';
import 'package:odac_flutter_app/data/models/me/ResponseProfileModel.dart';

part 'ResponseMeInfoModel.g.dart';

@JsonSerializable()
class ResponseMeInfoModel {
  final String email;
  final String nick;
  final ResponseProfileModel profile;

  ResponseMeInfoModel({
    required this.email,
    required this.nick,
    required this.profile,
  });

  factory ResponseMeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoModelToJson(this);

  ResponseMeInfoModel copyWith({
    String? email,
    String? nick,
    ResponseProfileModel? profile,
  }) {
    return ResponseMeInfoModel(
      email: email ?? this.email,
      nick: nick ?? this.nick,
      profile: profile ?? this.profile
    );
  }
}
