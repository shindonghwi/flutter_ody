import 'package:flutter/material.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeNotificationModel.dart';
import 'package:ody_flutter_app/presentation/features/cache/UserCache.dart';
import 'package:riverpod/riverpod.dart';

final meInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) {
    if (meInfo == null) {
      firebaseAuth.signOut();
    }
    state = meInfo;
    userCache.setUserInfo(meInfo);
  }

  void updateMeInfoNick(String nick) {
    ResponseMeInfoModel meInfo = state!.copyWith(
      nick: nick,
    );
    debugPrint("updateMeInfoNick : ${meInfo.toJson()}");
    state = meInfo;
  }

  void updateMeInfoHeight(int height) {
    ResponseMeInfoModel meInfo = state!.copyWith(profile: state!.profile?.copyWith(height: height));
    debugPrint("updateMeInfoHeight : ${meInfo.toJson()}");
    state = meInfo;
  }

  void updateMeInfoWeight(int weight) {
    ResponseMeInfoModel meInfo = state!.copyWith(profile: state!.profile?.copyWith(weight: weight));
    debugPrint("updateMeInfoHeight : ${meInfo.toJson()}");
    state = meInfo;
  }

  void updateMeConfigNotification(ResponseMeNotificationModel notification) {
    ResponseMeInfoModel meInfo = state!.copyWith(config: state!.config?.copyWith(notification: notification));
    debugPrint("updateMeConfigNotification : ${meInfo.config?.notification?.toJson()}");
    state = meInfo;
  }
}
