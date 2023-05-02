import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/CalendarFormatProvider.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/CalendarHeightProvider.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/DimProvider.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/DimBackgroundView.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:table_calendar/table_calendar.dart';

/// @feature: 드래그 가능한 캘린터 뷰
/// @author: 2023/05/01 2:05 PM donghwishin
class CalendarContainerView extends HookWidget {
  final Widget child;
  final double calendarMinHeight;
  final double calendarMaxHeight;

  const CalendarContainerView({
    Key? key,
    required this.child,
    required this.calendarMinHeight,
    required this.calendarMaxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableContainer(
      initialHeight: calendarMinHeight,
      minHeight: calendarMinHeight,
      maxHeight: calendarMaxHeight,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
          color: getColorScheme(context).white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8D8D8D).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// 드래그 가능한 컨테이너 위젯
class DraggableContainer extends HookConsumerWidget {
  final Widget child;
  final double initialHeight;
  final double minHeight;
  final double maxHeight;

  const DraggableContainer({
    super.key,
    required this.child,
    required this.initialHeight,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDimOnRead = ref.read(DimProvider.notifier);
    final calendarHeightRead = ref.read(CalendarHeightProvider.notifier);
    final calendarFormatRead = ref.read(CalendarFormatProvider.notifier);
    final turningPoint = CalendarSize.turningHeight(context);

    return HookBuilder(
      builder: (context) {
        void onVerticalDragDown(DragDownDetails details) {}

        void onVerticalDragUpdate(DragUpdateDetails details) {
          calendarHeightRead.updateHeight(calendarHeightRead.getHeight() + details.delta.dy);;
          calendarHeightRead.updateHeight(calendarHeightRead.getHeight().clamp(minHeight, maxHeight));

          if (calendarHeightRead.getHeight() < turningPoint) {
            calendarFormatRead.updateFormat(CalendarFormat.week);
          } else {
            calendarFormatRead.updateFormat(CalendarFormat.month);
          }

        }

        void onVerticalDragEnd(DragEndDetails details) {
          double containerCurrentHeight = calendarHeightRead.getHeight();
          double collapseBoundary = minHeight + ((maxHeight - minHeight) / 2);
          bool isExpanded = containerCurrentHeight >= collapseBoundary;

          if (isExpanded) {
            calendarHeightRead.updateHeight(maxHeight);
          } else {
            calendarHeightRead.updateHeight(minHeight);
          }

          isDimOnRead.change(isExpanded);
        }

        return GestureDetector(
          onVerticalDragDown: onVerticalDragDown,
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: onVerticalDragEnd,
          child: Stack(
            children: [
              DimBackgroundView(
                onBackgroundTap: () {
                  calendarHeightRead.updateHeight(minHeight);
                  calendarFormatRead.updateFormat(CalendarFormat.week);
                  isDimOnRead.change(false);
                },
              ),
              _InnerContent(child: child),
            ],
          ),
        );
      },
    );
  }
}

class _InnerContent extends HookConsumerWidget {
  const _InnerContent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerHeight = ref.watch<double>(CalendarHeightProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: containerHeight,
      child: child,
    );
  }
}
