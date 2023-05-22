import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

class RecordBloodPressureAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const RecordBloodPressureAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bgRecorder = ref.watch<Triple<int, int, int>>(bloodPressureRecorderProvider);

    final actionTextColor = (bgRecorder.first.toString().length >= 2 &&
        bgRecorder.second.toString().length >= 2)
        ? getColorScheme(context).colorText
        : getColorScheme(context).neutral50;

    return IconTitleTextAppBar(
      leadingIcon: AppBarIcon(
        path: 'assets/imgs/icon_back.svg',
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: getAppLocalizations(context).record_blood_pressure,
      actionText: getAppLocalizations(context).common_save,
      actionTextColor: actionTextColor,
      actionTextCallback: () {},
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
