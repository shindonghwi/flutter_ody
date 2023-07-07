import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SocialLoginModel.g.dart';

@JsonSerializable()
class SocialLoginModel {
  final LoginPlatform loginPlatform;
  final String? accessToken;

  SocialLoginModel(this.loginPlatform, this.accessToken);

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) => _$SocialLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLoginModelToJson(this);
}
