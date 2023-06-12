import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/env/Environment.dart';
// import 'package:odac_flutter_app/firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'ody-product',
  );
  Environment.newInstance(BuildType.prod).run();
}