import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/FillButtonSize.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/model/OutlineButtonSize.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OutlineRoundNeutralButton extends HookConsumerWidget {
  final String text;
  final ButtonSizeType type;
  final VoidCallback onPressed;
  final buttonProvider;

  const OutlineRoundNeutralButton({
    Key? key,
    required this.text,
    required this.type,
    required this.onPressed,
    required this.buttonProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch<ButtonState>(buttonProvider);
    final buttonRead = ref.read<ButtonNotifier>(buttonProvider.notifier);
    final buttonHeight = OutlineButtonSize.getButtonHeight(type);
    final buttonPadding = OutlineButtonSize.getButtonPadding(type);
    final buttonStateSave = useState(buttonState);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTapDown: (_) {
          if (buttonState == ButtonState.Disabled) return;
          buttonRead.changeState(ButtonState.Pressed);
        },
        onTapUp: (_) {
          if (buttonState == ButtonState.Disabled) return;

          if (buttonStateSave.value == ButtonState.Activated) {
            buttonRead.changeState(ButtonState.Default);
            buttonStateSave.value = ButtonState.Default;
          } else {
            buttonRead.changeState(ButtonState.Activated);
            buttonStateSave.value = ButtonState.Activated;
          }
          onPressed();
        },
        onTapCancel: () {
          if (buttonState == ButtonState.Disabled) return;
          buttonRead.changeState(ButtonState.Default);
        },
        child: Container(
          height: buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _getBorderColor(context, buttonState),
              width: 1.5,
            ),
            color: _getBackgroundColor(context, buttonState),
          ),
          child: Center(
            child: Text(
              text,
              style: getTextTheme(context).l3m.copyWith(
                    color: _getTextColor(context, buttonState),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).neutral50;
      case ButtonState.Pressed:
        return getColorScheme(context).neutral50;
      case ButtonState.Disabled:
        return getColorScheme(context).neutral50;
      case ButtonState.Activated:
        return getColorScheme(context).neutral100;
    }
  }

  Color _getBackgroundColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).colorUI01;
      case ButtonState.Pressed:
        return getColorScheme(context).neutral100.withOpacity(0.05);
      case ButtonState.Disabled:
        return getColorScheme(context).neutral50.withOpacity(0.05);
      case ButtonState.Activated:
        return getColorScheme(context).neutral100;
    }
  }

  Color _getTextColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).neutral50;
      case ButtonState.Pressed:
        return getColorScheme(context).neutral50;
      case ButtonState.Disabled:
        return getColorScheme(context).neutral50.withOpacity(0.05);
      case ButtonState.Activated:
        return getColorScheme(context).white;
    }
  }
}
