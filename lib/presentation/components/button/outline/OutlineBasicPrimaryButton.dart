import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/FillButtonSize.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/button/model/OutlineButtonSize.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class OutlineBasicPrimaryButton extends HookConsumerWidget {
  final String text;
  final ButtonSizeType type;
  final VoidCallback onPressed;
  final buttonProvider;

  const OutlineBasicPrimaryButton({
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
        borderRadius: BorderRadius.circular(10),
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
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _getBorderColor(context, buttonState),
              width: 1.5,
            ),
            color: _getBackgroundColor(context, buttonState),
          ),
          child: Padding(
            padding: buttonPadding,
            child: Center(
              child: Text(
                text,
                style: getTextTheme(context).l1m.copyWith(
                      color: _getTextColor(context, buttonState),
                    ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).neutral30;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryFocus;
      case ButtonState.Disabled:
        return getColorScheme(context).colorPrimaryDisable;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryFocus;
    }
  }

  Color _getBackgroundColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).colorUI01;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryFocus.withOpacity(0.05);
      case ButtonState.Disabled:
        return getColorScheme(context).colorUI01;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryFocus.withOpacity(0.15);
    }
  }

  Color _getTextColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).colorText;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryFocus;
      case ButtonState.Disabled:
        return getColorScheme(context).colorPrimaryDisable;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryFocus;
    }
  }
}
