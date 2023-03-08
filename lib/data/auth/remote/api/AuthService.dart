import '../../../../domain/auth/entity/LoginEntity.dart';

abstract class AuthService {
  Future<LoginEntity> doKakaoLogin();
}
