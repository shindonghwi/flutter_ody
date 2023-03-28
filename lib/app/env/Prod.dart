import 'package:odac_flutter_app/app/env/Environment.dart';

main() async => {
      Environment.newInstance(BuildType.prod).run(),
    };
