import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineCheckListProvider.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineListProvider.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineScreenModeProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class MedicineBottomContent extends HookConsumerWidget {
  const MedicineBottomContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiStateRead = ref.read(medicineListProvider.notifier);
    final checkList = ref.watch(medicineCheckListProvider);
    final isEditMode = ref.watch(medicineScreenModeProvider);

    return Align(
      alignment: Alignment.bottomRight,
      child: !isEditMode
          ? const _FloatingButton()
          : Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: FillButton(
                text:
                    "${getAppLocalizations(context).common_delete}${getAppLocalizations(context).common_complete}",
                type: ButtonSizeType.Normal,
                onPressed: () => uiStateRead.removeMedicines(checkList),
                buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                    state: checkList.isNotEmpty ? ButtonState.Activated : ButtonState.Disabled,
                  ),
                ),
              ),
            ),
    );
  }
}

class _FloatingButton extends HookConsumerWidget {
  const _FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmItemsRead = ref.read(medicineListProvider.notifier);
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(bottom: 48, right: 24),
      decoration: BoxDecoration(
        color: getColorScheme(context).primary100,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: getColorScheme(context).primary100.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            ResponseMeMedicineModel data = await Navigator.push(
              context,
              nextSlideScreen(RoutingScreen.AddMedication.route),
            );

            if (data.medicineSeq != null) {
              alarmItemsRead.addMedicine(data);
            }
          },
          child: SvgPicture.asset(
            'assets/imgs/icon_plus_btn.svg',
            colorFilter: ColorFilter.mode(
              getColorScheme(context).white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
