import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AdvertiseHelper {
  static const String PLUGIN_PANGLE_BANNER = "plugin/pangle_banner";
  static const String CHANNEL_PANGLE_BANNER = "channel/pangle_banner";

  static void initPangleBannerAd({
    required Function() onAdLoaded,
    required Function() onAdError,
  }) async {
    const _platform = EventChannel(CHANNEL_PANGLE_BANNER);

    Future.delayed(const Duration(seconds: 1), () async {
      _platform.receiveBroadcastStream().listen((event) {
        debugPrint("initPangleBannerAd event: ${event.toString()}");
      });
    });
  }
}
