import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/di/DiModule.dart';
import 'package:odac_flutter_app/app/domain/auth/usecase/KakaoLoginUseCase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final kakaoLoginUseCase = getIt.get<KakaoLoginUseCase>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              kakaoLoginUseCase.call();
            },
            child: Text('KakaoLogin'),
          ),
        ),
      ),
    );
  }
}
