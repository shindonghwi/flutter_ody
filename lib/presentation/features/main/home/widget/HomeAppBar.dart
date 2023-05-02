import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/CalendarPageProvider.dart';
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
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPageDatetime = ref.watch<DateTime>(CalendarPageProvider);

    return AppBar(
      leadingWidth: 180,
      toolbarHeight: 56,
      bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: getColorScheme(context).white,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
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
      actions: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                "assets/imgs/icon_setting.svg",
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).neutral100,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  "assets/imgs/icon_alrmoff.svg",
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).neutral100,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
