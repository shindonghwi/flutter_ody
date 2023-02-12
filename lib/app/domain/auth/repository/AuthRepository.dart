import 'package:either_dart/either.dart';
import 'package:odac_flutter_app/app/domain/auth/entity/LoginEntity.dart';
import 'package:odac_flutter_app/app/domain/base/BaseFailure.dart';

abstract class AuthRepository {
  /**
   * @feature: 카카오 로그인
   *
   * @author: 2023/02/10 7:01 PM donghwishin
   *
   * @description{
   *
   * }
   */
  Future<Either<LoginEntity, Failure>> doKakaoLogin();
}
