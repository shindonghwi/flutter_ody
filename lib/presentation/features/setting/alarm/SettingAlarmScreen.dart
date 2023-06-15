import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/features/setting/alarm/widget/AlarmSwitch.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class SettingAlarmScreen extends StatelessWidget {
  const SettingAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).black,
        ),
        title: getAppLocalizations(context).setting_alarm_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const _AllAlarmContainer(),
            _divider(context),
            const _SubAlarmContainer(),
            _divider(context),
            const _ReportAlarmContainer(),
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

class _AllAlarmContainer extends HookConsumerWidget {
  const _AllAlarmContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOn = useState(true);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlarmSwitch(
            title: getAppLocalizations(context).setting_alarm_total,
            isOn: isOn.value,
            callback: (value) {
              isOn.value = value;
            },
          ),
          const SizedBox(height: 8),
          Text(
            getAppLocalizations(context).setting_alarm_total_description,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).neutral70,
                  height: 1.33,
                ),
          )
        ],
      ),
    );
  }
}

class _SubAlarmContainer extends HookConsumerWidget {
  const _SubAlarmContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contents = [
      Pair(getAppLocalizations(context).setting_alarm_medication, useState(true)),
      Pair(getAppLocalizations(context).setting_alarm_walk, useState(true)),
      Pair(getAppLocalizations(context).setting_alarm_bp, useState(true)),
      Pair(getAppLocalizations(context).setting_alarm_glucose, useState(true)),
    ];

    final alarmList = ListView.separated(
      itemCount: contents.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 32); // Adjust the height as needed
      },
      itemBuilder: (BuildContext context, int index) {
        var e = contents[index];
        return Column(
          children: [
            AlarmSwitch(
              title: e.first,
              isOn: e.second.value,
              callback: (value) {
                e.second.value = value;
              },
            ),
          ],
        );
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    );

    return Container(
      padding: const EdgeInsets.all(24),
      child: alarmList,
    );
  }
}

class _ReportAlarmContainer extends HookWidget {
  const _ReportAlarmContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlarmSwitch(
            title: getAppLocalizations(context).setting_alarm_report,
            isOn: true,
            callback: (value) {},
          ),
          const SizedBox(height: 8),
          Text(
            getAppLocalizations(context).setting_alarm_report_description,
            style: getTextTheme(context)
                .c2r
                .copyWith(color: getColorScheme(context).neutral70, height: 1.33),
          )
        ],
      ),
    );
  }
}
