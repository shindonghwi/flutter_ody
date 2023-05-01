import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/DimProvider.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/DimBackgroundView.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: 드래그 가능한 캘린터 뷰
 *
 * @author: 2023/05/01 2:05 PM donghwishin
 */
class CalendarContainerView extends HookWidget {
  final Widget child;
  final double calendarMinHeight;
  final double calendarMaxHeight;

  const CalendarContainerView({
    Key? key,
    required Widget this.child,
    required double this.calendarMinHeight,
    required double this.calendarMaxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableContainer(
      initialHeight: calendarMinHeight,
      minHeight: calendarMinHeight,
      maxHeight: calendarMaxHeight,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
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

/** 드래그 가능한 컨테이너 위젯 */
class DraggableContainer extends HookConsumerWidget {
  final Widget child;
  final double initialHeight;
  final double minHeight;
  final double maxHeight;

  DraggableContainer({
    required this.child,
    required this.initialHeight,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDimOnRead = ref.read(DimProvider.notifier);
    final _containerHeight = useState(initialHeight);

    void _onVerticalDragDown(DragDownDetails details) {}

    void _onVerticalDragUpdate(DragUpdateDetails details) {
      _containerHeight.value += details.delta.dy;
      _containerHeight.value = _containerHeight.value.clamp(minHeight, maxHeight);
    }

    void _onVerticalDragEnd(DragEndDetails details) {
      double containerHeight = _containerHeight.value;
      double collapseBoundary = minHeight + ((maxHeight - minHeight) / 2);
      bool isExpanded = containerHeight >= collapseBoundary;

      if (isExpanded) {
        _containerHeight.value = maxHeight;
      } else {
        _containerHeight.value = minHeight;
      }

      isDimOnRead.change(isExpanded);
    }

    return GestureDetector(
      onVerticalDragDown: _onVerticalDragDown,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Stack(
        children: [
          DimBackgroundView(
            onBackgroundTap: () {
              _containerHeight.value = minHeight;
              isDimOnRead.change(false);
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: _containerHeight.value,
            child: child,
          ),
        ],
      ),
    );
  }
}
