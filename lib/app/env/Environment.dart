import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/di/locator.dart';
import 'package:ody_flutter_app/presentation/ui/theme.dart';

enum BuildType { dev, prod }

/**
 * @feature: 빌드 환경 구성
 *
 * @author: 2023/02/10 12:06 PM donghwishin
 *
 * @description{
 *   dev 환경, prod 환경에 따라서 다른 설정을 할 수 있도록 구성
 * }
 */
class Environment {
  const Environment._internal(this._buildType);

  final BuildType _buildType;
  static Environment _instance = const Environment._internal(BuildType.dev);

  static Environment get instance => _instance;

  static BuildType get buildType => _instance._buildType;

  static String get apiUrl =>
      _instance._buildType == BuildType.dev ? 'https://dev-appapi.ody.life' : 'https://dev-appapi.ody.life'; // api 주소

  static String get apiVersion =>
      _instance._buildType == BuildType.dev ? 'v1' : 'v1'; // api Version

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  bool get isDebuggable => _buildType == BuildType.dev;

  void run() async{
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    initServiceLocator();

    runApp(const ProviderScope(child: OrotApp()));

  }
}
