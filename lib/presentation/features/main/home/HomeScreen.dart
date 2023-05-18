import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/calendar/CalendarContainerView.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/calendar/CalendarContentView.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/card/CardRecordItems.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/card/CardTodayRecord.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/HomeAppBar.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      appBar: const HomeAppBar(),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: getColorScheme(context).colorUI02,
                  margin: EdgeInsets.only(top: CalendarSize.underMargin(context)),
                  child: const CardTodayRecord(),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
              const CardRecordItems(),
              const SliverPadding(padding: EdgeInsets.only(bottom: 57.0))
            ],
          ),
          floatingButton(context),
          CalendarContainerView(
            calendarMinHeight: CalendarSize.minHeight(context),
            calendarMaxHeight: CalendarSize.maxHeight(context),
            child: CalendarContentView(
              maxHeight: CalendarSize.maxHeight(context),
            ),
          ),
        ],
      ),
    );
  }

  Positioned floatingButton(BuildContext context) {
    return Positioned(
      bottom: 17,
      right: 20,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: getColorScheme(context).primary100,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8D8D8D).withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(2, 5), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Icon(
              Icons.add,
              color: getColorScheme(context).white,
            ),
          ),
        ),
      ),
    );
  }
}
