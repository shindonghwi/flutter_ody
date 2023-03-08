import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:odac_flutter_app/app/di/DiModule.dart';
import 'package:odac_flutter_app/app/env/Environment.dart';

main() async => {
      KakaoSdk.init(nativeAppKey: '388ad5e8072d463119af8b148ac06c75'),
      await DiModule().init(),
      Environment.newInstance(BuildType.dev).run(),
    };
