import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/OutlineDefaultButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

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
          child: OutlineDefaultButton(
            text: getAppLocalizations(context).common_man,
            borderRadius: 100,
            onPressed: () => isSelectedMan.value = !isSelectedMan.value,
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: isSelectedMan.value ? ButtonState.Activated : ButtonState.Default,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: OutlineDefaultButton(
            text: getAppLocalizations(context).common_woman,
            borderRadius: 100,
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
