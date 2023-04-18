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
    return Stack(
      children: [
        _BackgroundColor(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: HomeAppBar(),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 52),
              child: Column(
                children: [
                  HomeHeader(),
                  HomeTodayRecord(),
                  HomeTodayNews(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _BackgroundColor(BuildContext context) {
    return Container(
      height: getMediaQuery(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: getColorScheme(context).primary100,
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: getColorScheme(context).white,
            ),
          ),
        ],
      ),
    );
  }
}
