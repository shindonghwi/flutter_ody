import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/data/models/me/ResponseProfileModel.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:odac_flutter_app/presentation/features/constant/constants.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final meInfoProvider =
StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
      (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel meInfo) {
    state = meInfo;
  }

  void updateMeInfoNick(String nick) {
    ResponseMeInfoModel meInfo = state!.copyWith(
        nick: nick,
    );
    debugPrint("updateMeInfoNick : ${meInfo.toJson()}");
    state = meInfo;
  }

  void updateMeInfoHeight(int height) {
    ResponseMeInfoModel meInfo = state!.copyWith(
        profile: state!.profile.copyWith(height: height)
    );
    debugPrint("updateMeInfoHeight : ${meInfo.toJson()}");
    state = meInfo;
  }

  void updateMeInfoWeight(int weight) {
    ResponseMeInfoModel meInfo = state!.copyWith(
        profile: state!.profile.copyWith(weight: weight)
    );
    debugPrint("updateMeInfoHeight : ${meInfo.toJson()}");
    state = meInfo;
  }

}
