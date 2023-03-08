import 'package:either_dart/either.dart';

import '../../base/BaseFailure.dart';
import '../entity/LoginEntity.dart';

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
