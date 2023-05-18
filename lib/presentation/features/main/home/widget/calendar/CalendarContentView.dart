import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarFormatNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarHeightNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/DimNotifier.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarContentView extends HookConsumerWidget {
  final double maxHeight;

  const CalendarContentView({
    super.key,
    required double this.maxHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDimOnRead = ref.read(dimProvider.notifier);
    final calendarFormat = ref.watch<CalendarFormat>(calendarFormatProvider);
    final calendarFormatRead = ref.read(calendarFormatProvider.notifier);
    final calendarPageRead = ref.read(calendarPageProvider.notifier);
    final calendarSelectDateRead = ref.read(calendarSelectDateProvider.notifier);
    final calendarHeightRead = ref.read(calendarHeightProvider.notifier);

    final _selectedDay = useState(DateTime.now());
    final _focusedDay = useState(DateTime.now());

    final _firstDay = DateTime.now().subtract(
      const Duration(days: 365 * 10 + 2),
    ); // 10년 전

    final _lastDay = DateTime.now().add(
      const Duration(days: 365 * 10 + 2),
    ); // 10년 후

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: TableCalendar(
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
                // 애니메이션 제거
                pageAnimationEnabled: false,

                daysOfWeekHeight: 42,
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay.value,
                calendarFormat: calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay.value, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  isDimOnRead.change(false);
                  _selectedDay.value = selectedDay;
                  _focusedDay.value = focusedDay;
                  calendarPageRead.updatePageDatetime(selectedDay);
                  calendarSelectDateRead.updateSelectedDatetime(selectedDay);
                  calendarHeightRead.updateHeight(CalendarSize.minHeight(context));
                  calendarFormatRead.updateFormat(CalendarFormat.week);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay.value = focusedDay;
                  calendarPageRead.updatePageDatetime(focusedDay);
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
                              color: getColorScheme(context).colorText.withOpacity(day.month == focusedDay.month ? 1 : 0.3),
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
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 3,
                width: 35,
                decoration: BoxDecoration(
                  color: getColorScheme(context).neutral40,
                  borderRadius: BorderRadius.circular(100),
                ),
                margin: const EdgeInsets.only(top: 22, bottom: 8),
              ),
            )
          ],
        );
      },
    );
  }
}
