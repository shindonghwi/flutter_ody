import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/button/outline/OutlineRoundPrimaryButton.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/InputProfileDiseaseSelectNotifier.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class DiseaseSelector extends HookConsumerWidget {
  const DiseaseSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DiseaseType> diseaseItemList = [
      DiseaseType.HealthCare,
      DiseaseType.Hypertension,
      DiseaseType.DiabetesMellitus,
    ];

    final diseaseActiveStateList = ref.watch<List<DiseaseType>>(diseaseListStateProvider);
    final diseaseListRead = ref.read(diseaseListStateProvider.notifier);

    String getDiseaseName(DiseaseType type) {
      switch (type) {
        case DiseaseType.HealthCare:
          return getAppLocalizations(context).input_profile_disease_item_health_manage;
        case DiseaseType.Hypertension:
          return getAppLocalizations(context).input_profile_disease_item_blood_pressure;
        case DiseaseType.DiabetesMellitus:
          return getAppLocalizations(context).input_profile_disease_item_glucose;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: diseaseItemList.map((type) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          child: OutlineRoundPrimaryButton(
            text: getDiseaseName(type),
            onPressed: () => diseaseListRead.click(type),
            type: ButtonSizeType.Normal,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: diseaseActiveStateList.contains(type)
                    ? ButtonState.Activated
                    : ButtonState.Default,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
