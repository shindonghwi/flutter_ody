import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/DraggableCalendarView.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/TodayRecordCard.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';

import '../../../utils/Common.dart';
import 'widget/HomeAppBar.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarMinHeight = getMediaQuery(context).size.height * 0.15;
    final mainContentTopMargin = getMediaQuery(context).size.height * 0.18;
    final calendarMaxHeight = getMediaQuery(context).size.height * 0.38;

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      appBar: HomeAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: getColorScheme(context).colorUI02,
              margin: EdgeInsets.only(top: mainContentTopMargin),
              padding: EdgeInsets.only(bottom: 57),
              child: Column(
                children: [
                  TodayRecordCard(),
                ],
              ),
            ),
          ),
          DraggableCalendarView(
            calendarMinHeight: calendarMinHeight,
            calendarMaxHeight: calendarMaxHeight,
          )
        ],
      ),
    );
  }
}
