import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/widget/MedicationName.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/widget/MedicationTime.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/widget/MedicationYoil.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class AddMedicationScreen extends StatelessWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

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
        title: getAppLocalizations(context).add_medication_title,
      ),
      body: Column(
        children: [
          const MedicationName(),
          const SizedBox(height: 32),
          const MedicationYoil(),
          const SizedBox(height: 32),
          const MedicationTime(),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 58),
            child: FillButton(
              text: getAppLocalizations(context).common_complete,
              type: ButtonSizeType.Normal,
              onPressed: () {},
              buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                (_) => ButtonNotifier(
                  state: ButtonState.Activated,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
