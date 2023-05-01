import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/DraggableCalendarView.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/HomeAppBar.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/CardRecordItems.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/CardTodayRecord.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarMinHeight = getMediaQuery(context).size.height * 0.15;
    final mainContentTopMargin = getMediaQuery(context).size.height * 0.18;
    final calendarMaxHeight = getMediaQuery(context).size.height * 0.38;

    final isCalendarExpanded = useState<bool>(false);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      appBar: HomeAppBar(),
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: getColorScheme(context).colorUI02,
                  margin: EdgeInsets.only(top: mainContentTopMargin),
                  child: CardTodayRecord(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 24.0),
              ),
              CardRecordItems(),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 57.0),
              )
            ],
          ),
          _FloatingButton(context),
          _BackgroundView(context, isCalendarExpanded.value),
          DraggableCalendarView(
            calendarMinHeight: calendarMinHeight,
            calendarMaxHeight: calendarMaxHeight,
            onExpandCollapse: (bool isExpanded) {
              isCalendarExpanded.value = isExpanded;
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _BackgroundView(BuildContext context, bool isCalendarExpanded) {
    final minAlpha = 0.0;
    final maxAlpha = 0.3;
    final duration = 300;
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: duration),
      tween: Tween<double>(begin: minAlpha, end: isCalendarExpanded ? maxAlpha : minAlpha),
      builder: (_, value, child) {
        if (value != maxAlpha) {
          return IgnorePointer(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: getColorScheme(context).black.withOpacity(value),
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: getColorScheme(context).black.withOpacity(value),
          );
        }
      },
    );
  }

  Positioned _FloatingButton(BuildContext context) {
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
              color: Color(0xFF8D8D8D).withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(2, 5), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
