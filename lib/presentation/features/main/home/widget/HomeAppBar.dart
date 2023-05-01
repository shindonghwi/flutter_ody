import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/CalendarProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: 홈 화면 앱바
 *
 * @author: 2023/05/01 2:04 PM donghwishin
 *
 * @description{
 *   날짜 선택, actions 아이콘
 * }
*/
class HomeAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity, 56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDatetime = ref.watch<DateTime>(CalendarProvider);
    return AppBar(
      leadingWidth: 150,
      toolbarHeight: 56,
      bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: getColorScheme(context).primary100,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(width: 20),
              Text(
                "${selectedDatetime.month}월",
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).neutral100,
                    ),
              ),
              SizedBox(width: 8),
              Text(
                "2023년",
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
      actions: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(
              "assets/imgs/icon_alrmoff.svg",
              colorFilter: ColorFilter.mode(
                getColorScheme(context).colorUI01,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
