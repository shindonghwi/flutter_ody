import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/CustomDraggableContainer.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class DraggableCalendarView extends StatelessWidget {
  final calendarMinHeight;
  final calendarMaxHeight;

  const DraggableCalendarView({
    Key? key,
    required this.calendarMinHeight,
    required this.calendarMaxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDraggableContainer(
      child: Container(
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
      ),
      initialHeight: calendarMinHeight,
      minHeight: calendarMinHeight,
      maxHeight: calendarMaxHeight,
      onExpandCollapse: (isExpanded) {
        debugPrint('isExpanded: $isExpanded');
        // Handle expand/collapse state change
      },
    );
  }
}
