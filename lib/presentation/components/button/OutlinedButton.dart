import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/notifier/OutlineButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OutlineButton extends ConsumerWidget {
  final String text;
  final VoidCallback onPressed;
  final outlineButtonProvider;

  const OutlineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.outlineButtonProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch<ButtonState>(outlineButtonProvider);
    final buttonRead = ref.read<OutlineButtonNotifier>(outlineButtonProvider.notifier);

    return GestureDetector(
      onTapDown: (_) {
        if (buttonState == ButtonState.Disabled) return;
        buttonRead.changeState(ButtonState.Pressed);
      },
      onTapUp: (_) {
        if (buttonState == ButtonState.Disabled) return;
        buttonRead.changeState(ButtonState.Default);
        onPressed();
      },
      onTapCancel: () => buttonRead.changeState(ButtonState.Default),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: buttonState == ButtonState.Disabled
                ? getColorScheme(context).colorPrimaryDisable
                : getColorScheme(context).colorPrimaryDefault,
            width: 1.5,
          ),
          color: buttonState == ButtonState.Disabled
              ? getColorScheme(context).colorUI01
              : buttonState == ButtonState.Pressed
                  ? getColorScheme(context).colorPrimaryDefault.withOpacity(0.05)
                  : getColorScheme(context).colorPrimaryDefault.withOpacity(0.15),
        ),
        child: Text(
          text,
          style: getTextTheme(context).l1.copyWith(
            color: buttonState == ButtonState.Disabled
                ? getColorScheme(context).colorText
                : getColorScheme(context).colorPrimaryDefault,
          ),
        ),
      ),
    );
  }
}
