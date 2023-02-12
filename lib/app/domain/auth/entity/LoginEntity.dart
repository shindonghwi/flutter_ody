import 'package:odac_flutter_app/app/data/auth/remote/dto/LoginResponse.dart';

class LoginEntity {
  String token;

  LoginEntity({required this.token});

  factory LoginEntity.toEntity(LoginResponse loginResponse) {
    return LoginEntity(token: loginResponse.token!);
  }

  Map toJson() => {"token": token};
}
