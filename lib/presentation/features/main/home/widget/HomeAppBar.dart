import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/BottomSheetCalendarSetting.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarFormatNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarHeightNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/MonthlyBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:table_calendar/table_calendar.dart';

/// @feature: 홈 화면 앱바
///
/// @author: 2023/05/01 2:04 PM donghwishin
///
/// @description{
///   날짜 선택, actions 아이콘
/// }
class HomeAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageDatetime = ref.watch<DateTime>(calendarPageProvider);
    final calendarFormatRead = ref.read(calendarFormatProvider.notifier);
    final calendarPageRead = ref.read(calendarPageProvider.notifier);
    final calendarSelectDateRead = ref.read(calendarSelectDateProvider.notifier);
    final calendarHeightRead = ref.read(calendarHeightProvider.notifier);
    final monthlyBioInfoRead = ref.read(monthlyBioInfoProvider.notifier);

    return AppBar(
      leadingWidth: 180,
      toolbarHeight: 56,
      bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: getColorScheme(context).white,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            CommonBottomSheet.showBottomSheet(
              context,
              child: BottomSheetCalendarSetting(
                callback: (DateTime dateTime) async {
                  calendarPageRead.updatePageDatetime(dateTime);
                  calendarSelectDateRead.updateSelectedDatetime(dateTime);
                },
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "${currentPageDatetime.month}월",
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).neutral100,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                "${currentPageDatetime.year}년",
                style: getTextTheme(context).t3sb.copyWith(
                      color: getColorScheme(context).neutral100,
                    ),
              ),
              SvgPicture.asset(
                'assets/imgs/icon_down.svg',
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).neutral100,
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        ),
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 4.0),
      //     child: Material(
      //       color: Colors.transparent,
      //       child: InkWell(
      //         onTap: () {},
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: SvgPicture.asset(
      //             "assets/imgs/icon_alrmoff.svg",
      //             colorFilter: ColorFilter.mode(
      //               getColorScheme(context).neutral100,
      //               BlendMode.srcIn,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
