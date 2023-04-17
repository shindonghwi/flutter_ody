import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/OutlineButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfileDiseaseListStateProvider.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class DiseaseSelector extends HookConsumerWidget {
  const DiseaseSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diseaseItemList = [
      getAppLocalizations(context).input_profile_disease_item_health_manage,
      getAppLocalizations(context).input_profile_disease_item_blood_pressure,
      getAppLocalizations(context).input_profile_disease_item_glucose,
    ];

    final diseaseActiveStateList = ref.watch<List<bool>>(diseaseListStateProvider);
    final diseaseListRead = ref.read(diseaseListStateProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: diseaseActiveStateList.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          child: OutlineButton(
            text: diseaseItemList[index],
            borderRadius: 100,
            onPressed: () => diseaseListRead.change(index),
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: e ? ButtonState.Activated : ButtonState.Default,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
