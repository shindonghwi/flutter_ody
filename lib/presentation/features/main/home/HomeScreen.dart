import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/CardRecordItems.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/CardTodayRecord.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI03,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                CardTodayRecord(),
                CardRecordItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
