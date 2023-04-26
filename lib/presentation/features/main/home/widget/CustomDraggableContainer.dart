import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDraggableContainer extends HookWidget {
  final double initialHeight;
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Function(bool) onExpandCollapse;

  CustomDraggableContainer({
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
