import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/features/setting/widget/SettingAppAlarmSwitch.dart';
import 'package:odac_flutter_app/presentation/features/setting/widget/SettingEtc.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SettingAlarmScreen extends StatelessWidget {
  const SettingAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // SizedBox(
    //   width: 43,
    //   height: 26,
    //   child: SwitchCheckBox(
    //     isOn: isSwitchOn.value,
    //     onChanged: (value) {
    //       isSwitchOn.value = !value;
    //     },
    //   ),
    // )

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).black,
        ),
        title: getAppLocalizations(context).setting_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SettingAppAlarmSwitch(),
            _divider(context),
            const SettingEtc()
          ],
        ),
      ),
    );
  }

  Container _divider(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8,
      color: getColorScheme(context).colorUI03,
    );
  }
}
