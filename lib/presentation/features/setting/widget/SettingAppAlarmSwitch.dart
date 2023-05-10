import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/switch/SwitchCheckbox.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SettingAppAlarmSwitch extends HookWidget {
  const SettingAppAlarmSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSwitchOn = useState(false);

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 알림 설정 타이틀
          _title(context),

          // 앱 알림 설정 스위치
          const SizedBox(height: 24),
          _switch(context, isSwitchOn),

          // 알림 설정 설명
          const SizedBox(height: 6),
          _description(context),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getAppLocalizations(context).setting_sub_menu_alarm_app,
          style: getTextTheme(context).t4m.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),
        SizedBox(
          width: 43,
          height: 26,
          child: SwitchCheckBox(
            isOn: isSwitchOn.value,
            onChanged: (value) {
              isSwitchOn.value = !value;
            },
          ),
        )
      ],
    );
  }

  Text _description(BuildContext context) {
    return Text(
      getAppLocalizations(context).setting_sub_menu_alarm_app_description,
      style: getTextTheme(context).c2r.copyWith(
            color: getColorScheme(context).neutral70,
          ),
    );
  }
}
