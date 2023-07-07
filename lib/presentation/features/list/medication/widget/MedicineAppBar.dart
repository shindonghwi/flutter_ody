import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineScreenModeProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class MedicineAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const MedicineAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(medicineScreenModeProvider);
    final isEditModeRead = ref.read(medicineScreenModeProvider.notifier);

    return IconTitleTextAppBar(
      leadingIcon: AppBarIcon(
        path: 'assets/imgs/icon_back.svg',
        onPressed: () {
          !isEditMode ? Navigator.of(context).pop() : isEditModeRead.changeMode(!isEditMode);
        },
        tint: getColorScheme(context).colorText,
      ),
      actionText: !isEditMode
          ? getAppLocalizations(context).common_edit
          : "",
      actionIconEnable: !isEditMode,
      actionTextColor: getColorScheme(context).colorText,
      actionTextCallback: () {
        isEditModeRead.changeMode(!isEditMode);
      },
      title: isEditMode
          ? getAppLocalizations(context).common_edit
          : getAppLocalizations(context).my_item_subtitle_pill,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
