import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ody_flutter_app/app/env/Environment.dart';
// import 'package:ody_flutter_app/firebase_options_dev.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Environment.newInstance(BuildType.prod).run();
}