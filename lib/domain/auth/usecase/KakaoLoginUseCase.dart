import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/di/DiModule.dart';
import 'package:odac_flutter_app/domain/auth/repository/AuthRepository.dart';

import '../../base/BaseFailure.dart';
import '../entity/LoginEntity.dart';

class KakaoLoginUseCase {
  final authRepository = getIt.get<AuthRepository>();

  Future<Either<LoginEntity, Failure>> call() async {
    debugPrint("KakaoLoginUseCase call() called");
    return await authRepository.doKakaoLogin();
  }
}
