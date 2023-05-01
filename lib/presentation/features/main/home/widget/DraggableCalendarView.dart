import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: 드래그 가능한 캘린터 뷰
 *
 * @author: 2023/05/01 2:05 PM donghwishin
 *
 * @description{
 *
 * }
*/
class DraggableCalendarView extends StatelessWidget {
  final Widget child;
  final double calendarMinHeight;
  final double calendarMaxHeight;
  final Function(bool) onExpandCollapse;

  const DraggableCalendarView({
    Key? key,
    required Widget this.child,
    required double this.calendarMinHeight,
    required double this.calendarMaxHeight,
    required Function(bool) this.onExpandCollapse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableContainer(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: getColorScheme(context).white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8D8D8D).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
      initialHeight: calendarMinHeight,
      minHeight: calendarMinHeight,
      maxHeight: calendarMaxHeight,
      onExpandCollapse: (isExpanded) => onExpandCollapse(isExpanded),
    );
  }
}

/** 드래그 가능한 컨테이너 위젯 */
class DraggableContainer extends HookWidget {
  final double initialHeight;
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Function(bool) onExpandCollapse;

  DraggableContainer({
    required this.child,
    required this.initialHeight,
    required this.minHeight,
    required this.maxHeight,
    required this.onExpandCollapse,
  });

  @override
  Widget build(BuildContext context) {
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

      onExpandCollapse(isExpanded);
    }

    return GestureDetector(
      onVerticalDragDown: _onVerticalDragDown,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: _containerHeight.value,
        child: child,
      ),
    );
  }
}
