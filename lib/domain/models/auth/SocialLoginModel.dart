import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';

class SocialLoginModel {
  final LoginPlatform loginPlatform;
  final String? accessToken;

  SocialLoginModel(this.loginPlatform, this.accessToken);
}
