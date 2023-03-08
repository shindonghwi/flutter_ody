import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/di/DiModule.dart';
import 'package:odac_flutter_app/data/auth/remote/api/AuthService.dart';
import 'package:odac_flutter_app/domain/auth/repository/AuthRepository.dart';
import 'package:odac_flutter_app/domain/base/BaseException.dart';

import '../../../domain/auth/entity/LoginEntity.dart';
import '../../../domain/base/BaseFailure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService = getIt.get<AuthService>();

  @override
  Future<Either<LoginEntity, Failure>> doKakaoLogin() async {
    debugPrint("AuthRepositoryImpl doKakaoLogin() called");
    try {
      var result = await authService.doKakaoLogin();
      return Left(result);
    } on BaseException catch (e) {
      return Right(BaseFailure(message: e.message, code: e.code!));
    }
  }
}
