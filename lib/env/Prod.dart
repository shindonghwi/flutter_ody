import 'package:odac_flutter_app/app/di/DiModule.dart';
import 'package:odac_flutter_app/env/Environment.dart';

main() async => {
      await DiModule().init(),
      Environment.newInstance(BuildType.prod).run(),
    };
