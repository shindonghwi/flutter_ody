import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/CalendarProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarContentView extends HookConsumerWidget {
  final double maxHeight;

  const CalendarContentView({Key? key, required double this.maxHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final calendarRead = ref.read(CalendarProvider.notifier);

    final _selectedDay = useState(DateTime.now());
    final _focusedDay = useState(DateTime.now());
    final _calendarFormat = useState(CalendarFormat.month);

    final _firstDay = DateTime.now().subtract(
      const Duration(days: 365 * 10 + 2),
    ); // 10년 전

    final _lastDay = DateTime.now().add(
      const Duration(days: 365 * 10 + 2),
    ); // 10년 후

    return LayoutBuilder(builder: (context, constraints) {

      if (constraints.minHeight < maxHeight / 3) {
        _calendarFormat.value = CalendarFormat.week;
      } else {
        _calendarFormat.value = CalendarFormat.month;
      }

      return TableCalendar(
        // 요일. 월 ~ 금
        daysOfWeekVisible: true,
        // 상단 날짜
        headerVisible: false,
        // 뷰포트 채우기
        shouldFillViewport: true,
        // 주차 표시
        weekNumbersVisible: false,
        // 6주 강제
        sixWeekMonthsEnforced: false,
        // 언어
        locale: Localizations.localeOf(context).languageCode,
        rowHeight: 42,
        daysOfWeekHeight: 42,
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _focusedDay.value,
        calendarFormat: _calendarFormat.value,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay.value, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          _selectedDay.value = selectedDay;
          _focusedDay.value = focusedDay;
        },
        onPageChanged: (focusedDay) {
          _focusedDay.value = focusedDay;
          calendarRead.updateCurrentDate(focusedDay);
        },
        onFormatChanged: (format) {
          _calendarFormat.value = format;
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
            String weekdayString = weekdays[day.weekday - 1];
            return Center(
              child: Text(
                weekdayString.toString(),
                style: getTextTheme(context).c1b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              width: 35,
              decoration: BoxDecoration(
                color: getColorScheme(context).colorPrimaryFocus,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: getTextTheme(context).c2b.copyWith(
                        color: getColorScheme(context).white,
                      ),
                ),
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                day.day.toString(),
                style: getTextTheme(context).c2b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                day.day.toString(),
                style: getTextTheme(context).c2b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                day.day.toString(),
                style: getTextTheme(context).c2b.copyWith(
                      color: getColorScheme(context).colorText.withOpacity(0.3),
                    ),
              ),
            );
          },
        ),
      );
    });
  }
}
