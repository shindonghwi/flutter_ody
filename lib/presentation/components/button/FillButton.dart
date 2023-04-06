import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSize.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class FillButton extends HookConsumerWidget {
  final String text;
  final double borderRadius;
  final ButtonSizeType type;
  final VoidCallback onPressed;
  final buttonProvider;

  const FillButton({
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
    final isActivated = useState(buttonState == ButtonState.Activated ? true : false);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTapDown: (_) {
          if (buttonState == ButtonState.Disabled) return;
          buttonRead.changeState(ButtonState.Pressed);
        },
        onTapUp: (_) {
          if (buttonState == ButtonState.Disabled) return;

          if (isActivated.value) {
            buttonRead.changeState(ButtonState.Default);
          } else {
            buttonRead.changeState(ButtonState.Activated);
          }
          onPressed();
          isActivated.value = !isActivated.value;
        },
        onTapCancel: () {
          if (buttonState == ButtonState.Disabled) return;
          buttonRead.changeState(ButtonState.Default);
        },
        child: Container(
          padding: buttonPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: _getBackgroundColor(context, buttonState),
            border: Border.all(
              color: _getBackgroundColor(context, buttonState),
              width: 1.5,
            )
          ),
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
    );
  }

  Color _getBackgroundColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).colorPrimaryDefault;
      case ButtonState.Pressed:
        return getColorScheme(context).colorPrimaryPress;
      case ButtonState.Disabled:
        return getColorScheme(context).colorPrimaryDisable;
      case ButtonState.Activated:
        return getColorScheme(context).colorPrimaryDefault;
    }
  }

  Color _getTextColor(BuildContext context, ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.Default:
        return getColorScheme(context).white;
      case ButtonState.Pressed:
        return getColorScheme(context).white;
      case ButtonState.Disabled:
        return getColorScheme(context).white;
      case ButtonState.Activated:
        return getColorScheme(context).white;
    }
  }
}
