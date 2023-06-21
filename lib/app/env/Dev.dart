import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/env/Environment.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Environment.newInstance(BuildType.dev).run();
}
