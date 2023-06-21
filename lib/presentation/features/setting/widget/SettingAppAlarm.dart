import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class SettingAppAlarm extends HookWidget {
  const SettingAppAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSwitchOn = useState(false);

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 16, top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 알림 설정 타이틀
          _title(context),

          // 앱 알림 설정 스위치
          const SizedBox(height: 24),
          _switch(context, isSwitchOn),
        ],
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).setting_sub_menu_alarm,
      style: getTextTheme(context).t2b.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }

  Widget _switch(
    BuildContext context,
    ValueNotifier<bool> isSwitchOn,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            nextSlideScreen(RoutingScreen.SettingAlarm.route),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getAppLocalizations(context).setting_sub_menu_alarm_app,
              style: getTextTheme(context).t4m.copyWith(
                    color: getColorScheme(context).colorText,
                  ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/imgs/icon_next_1_5_large.svg",
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).neutral60,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
