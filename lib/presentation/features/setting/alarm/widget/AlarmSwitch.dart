import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/switch/SwitchCheckBox.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class AlarmSwitch extends HookWidget {
  final String title;
  final bool isOn;
  final Function(bool) callback;

  const AlarmSwitch({
    Key? key,
    required this.title,
    required this.isOn,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 알림 설정 타이틀
        Text(
          title,
          style: getTextTheme(context).t4m.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),

        SizedBox(
          width: 43,
          height: 26,
          child: SwitchCheckBox(
            isOn: isOn,
            onChanged: (value) {
              callback.call(value);
            },
          ),
        )
      ],
    );
  }
}
