import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/login/widget/BackgroundGif.dart';
import 'package:odac_flutter_app/app/feature/login/widget/SocialLoginMenu.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundGif(),
          SocialLoginMenu(),
        ],
      ),
    );
  }
}
