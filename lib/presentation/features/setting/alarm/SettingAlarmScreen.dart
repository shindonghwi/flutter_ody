import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeNotificationModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/features/setting/alarm/provider/AlarmListProvider.dart';
import 'package:ody_flutter_app/presentation/features/setting/alarm/widget/AlarmSwitch.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class SettingAlarmScreen extends HookConsumerWidget {
  const SettingAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfo = ref.watch(meInfoProvider);
    final alarmListRead = ref.read(alarmListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (meInfo != null) {
          final notifications = meInfo.config?.notification;
          debugPrint("notifications : ${notifications?.toJson()}");
          if (notifications != null) {
            alarmListRead.updateList([
              notifications.all,
              notifications.medicine,
              notifications.step,
              notifications.bloodPressure,
              notifications.glucose,
              notifications.report,
            ]);
          }
        }
      });
    }, []);

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
    final meInfoRead = ref.read(meInfoProvider.notifier);
    final alarmList = ref.watch(alarmListProvider);
    final alarmListRead = ref.read(alarmListProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlarmSwitch(
            title: getAppLocalizations(context).setting_alarm_total,
            isOn: alarmList.first,
            callback: (value) {
              alarmListRead.changeAll();
              meInfoRead.updateMeConfigNotification(
                ResponseMeNotificationModel(
                    all: value,
                    medicine: value,
                    step: value,
                    bloodPressure: value,
                    glucose: value,
                    report: value,
                ),
              );
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
    final meInfoRead = ref.read(meInfoProvider.notifier);
    final alarmList = ref.watch(alarmListProvider);
    final alarmListRead = ref.read(alarmListProvider.notifier);

    final contents = [
      getAppLocalizations(context).setting_alarm_medication,
      getAppLocalizations(context).setting_alarm_walk,
      getAppLocalizations(context).setting_alarm_bp,
      getAppLocalizations(context).setting_alarm_glucose
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      child: ListView.separated(
        itemCount: contents.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 32); // Adjust the height as needed
        },
        itemBuilder: (BuildContext context, int index) {
          var content = contents[index];
          return Column(
            children: [
              AlarmSwitch(
                title: content,
                isOn: alarmList[index + 1],
                callback: (value) {
                  alarmListRead.changeIndex(index + 1);
                  meInfoRead.updateMeConfigNotification(
                    ResponseMeNotificationModel(
                      all: alarmList.first,
                      medicine: index == 0 ? value : alarmList[1],
                      step: index == 1 ? value : alarmList[2],
                      bloodPressure: index == 2 ? value : alarmList[3],
                      glucose: index == 3 ? value : alarmList[4],
                      report: alarmList.last,
                    ),
                  );
                },
              ),
            ],
          );
        },
        shrinkWrap: true,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _ReportAlarmContainer extends HookConsumerWidget {
  const _ReportAlarmContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoRead = ref.read(meInfoProvider.notifier);
    final alarmList = ref.watch(alarmListProvider);
    final alarmListRead = ref.read(alarmListProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlarmSwitch(
            title: getAppLocalizations(context).setting_alarm_report,
            isOn: alarmList.last,
            callback: (value) {
              alarmListRead.changeIndex(alarmList.length - 1);
              meInfoRead.updateMeConfigNotification(
                ResponseMeNotificationModel(
                  all: alarmList[0],
                  medicine: alarmList[1],
                  step: alarmList[2],
                  bloodPressure: alarmList[3],
                  glucose: alarmList[4],
                  report: value,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            getAppLocalizations(context).setting_alarm_report_description,
            style: getTextTheme(context).c2r.copyWith(color: getColorScheme(context).neutral70, height: 1.33),
          )
        ],
      ),
    );
  }
}
