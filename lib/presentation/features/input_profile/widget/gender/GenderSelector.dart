import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/outline/OutlineRoundPrimaryButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.isSelectedMan,
  });

  final ValueNotifier<bool> isSelectedMan;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlineRoundPrimaryButton(
            text: getAppLocalizations(context).common_man,
            onPressed: () => isSelectedMan.value = !isSelectedMan.value,
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: isSelectedMan.value ? ButtonState.Activated : ButtonState.Default,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: OutlineRoundPrimaryButton(
            text: getAppLocalizations(context).common_woman,
            onPressed: () => isSelectedMan.value = !isSelectedMan.value,
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: !isSelectedMan.value ? ButtonState.Activated : ButtonState.Default,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
