import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';


import '../../../utils/Common.dart';
import 'widget/HomeAppBar.dart';
import 'widget/HomeHeader.dart';
import 'widget/HomeTodayNews.dart';
import 'widget/HomeTodayRecord.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 52),
          child: Column(
            children: [
              HomeHeader(),
              HomeTodayRecord(),
              HomeTodayNews()
            ],
          ),
        ),
      ),
    );
  }
}
