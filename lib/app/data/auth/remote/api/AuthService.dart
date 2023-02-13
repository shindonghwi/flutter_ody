
import 'package:odac_flutter_app/app/domain/auth/entity/LoginEntity.dart';

abstract class AuthService {
  Future<LoginEntity> doKakaoLogin();
}