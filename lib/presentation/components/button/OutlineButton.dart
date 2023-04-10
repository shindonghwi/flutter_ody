import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSize.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OutlineButton extends HookConsumerWidget {
  final String text;
  final double borderRadius;
  final ButtonSizeType type;
  final VoidCallback onPressed;
  final buttonProvider;

  const OutlineButton({
    Key? key,
    this.borderRadius = 8,
    required this.text,
    required this.type,
    required this.onPressed,
    required this.buttonProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch<ButtonState>(buttonProvider);
    final buttonRead = ref.read<ButtonNotifier>(buttonProvider.notifier);
    final buttonPadding = ButtonSize.getButtonPadding(type);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTapDown: (_) {
          if (buttonState == ButtonState.Disabled) return;
          buttonRead.changeState(ButtonState.Pressed);
        },
        onTapUp: (_) {
          if (buttonState == ButtonState.Disabled) return;

          if (buttonState == ButtonState.Activated) {
            buttonRead.changeState(ButtonState.Default);
          } else {
            buttonRead.changeState(ButtonState.Activated);
          }
          onPressed();
        },
        onTapCancel: () {
          if (buttonState == ButtonState.Disabled) return;
          buttonRead.changeState(ButtonState.Default);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: _getBorderColor(context, buttonState),
              width: 1.5,
            ),
            color: _getBackgroundColor(context, buttonState),
          ),
          child: Padding(
            padding: buttonPadding,
            child: Text(
              text,
              style: getTextTheme(context).l1.copyWith(
                    color: _getTextColor(context, buttonState),
                  ),
              overflow: TextOverflow.ellipsis,
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
        return getColorScheme(context).colorPrimaryDisable;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryDefault;
      case ButtonState.Disabled:
        return getColorScheme(context).colorPrimaryDisable;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryDefault;
    }
  }

  Color _getBackgroundColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).colorUI01;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryDefault.withOpacity(0.05);
      case ButtonState.Disabled:
        return getColorScheme(context).colorUI01;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryDefault.withOpacity(0.15);
    }
  }

  Color _getTextColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).colorText;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryDefault;
      case ButtonState.Disabled:
        return getColorScheme(context).colorText;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryDefault;
    }
  }
}
