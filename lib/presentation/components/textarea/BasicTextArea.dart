import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class BasicTextArea extends HookWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLine;
  final int limit;
  final bool enabled;
  final bool autoFocus;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextFieldState fieldState;
  final bool showCounterText;
  final VoidCallback? onNextAction;
  final VoidCallback? onDoneAction;
  final Function(String value)? onChanged;
  final List<TextInputFormatter> inputFormatters;

  const BasicTextArea({
    Key? key,
    this.hint = '',
    this.limit = 10,
    this.maxLine = 1,
    this.enabled = true,
    this.autoFocus = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.showCounterText = false,
    this.onChanged = null,
    this.onNextAction = null,
    this.onDoneAction = null,
    this.inputFormatters = const [],
    required this.fieldState,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var content = useState('');

    List<TextInputFormatter> formatters = [...inputFormatters];
    formatters.add(LengthLimitingTextInputFormatter(limit));

    final focusNode = useFocusNode();
    final _isFocused = useState(false);
    useEffect(() {
      void onFocusChanged() => _isFocused.value = focusNode.hasFocus;
      focusNode.addListener(onFocusChanged);
      if (autoFocus) {
        Timer(Duration(milliseconds: 300), () => focusNode.requestFocus());
      }
      return () => focusNode.removeListener(onFocusChanged);
    }, [focusNode]);

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: formatters,
      focusNode: focusNode,
      maxLength: limit,
      maxLines: maxLine,
      decoration: InputDecoration(
        filled: true,
        enabled: enabled,
        fillColor: enabled ? getColorScheme(context).colorUI01 : getColorScheme(context).neutral30,
        counterText: showCounterText ? null : "",
        counterStyle: getTextTheme(context).c1r.copyWith(
              color:  _isFocused.value && content.value.length > 0
                  ? getColorScheme(context).neutral100
                  : getColorScheme(context).neutral50,
            ),
        border: getBorder(
          context,
          fieldState == TextFieldState.Complete ? TextFieldState.Complete : TextFieldState.Default,
        ),
        enabledBorder: getBorder(
          context,
          fieldState == TextFieldState.Complete ? TextFieldState.Complete : TextFieldState.Default,
        ),
        focusedBorder: getBorder(context, TextFieldState.Focus),
        focusedErrorBorder: getBorder(
          context,
          fieldState == TextFieldState.Error ? TextFieldState.Error : TextFieldState.Focus,
        ),
        errorBorder: getBorder(
          context,
          fieldState == TextFieldState.Error ? TextFieldState.Error : TextFieldState.Focus,
        ),
        disabledBorder: getBorder(context, TextFieldState.Disabled),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        hintText: hint,
        hintStyle: getTextTheme(context).c2r.copyWith(
              color: getColorScheme(context).neutral50,
            ),
      ),
      style: getTextTheme(context).c2r.copyWith(
            color: _isFocused.value
                ? getTextColor(context, TextFieldState.Focus)
                : getTextColor(
                    context,
                    fieldState == TextFieldState.Complete
                        ? TextFieldState.Complete
                        : TextFieldState.Default,
                  ),
          ),
      onChanged: (value) {
        content.value = value;
        onChanged?.call(value);
      },
      onTap: () => _isFocused.value = true,
      onFieldSubmitted: (value) => _isFocused.value = false,
      onEditingComplete: () {
        switch (textInputAction) {
          case TextInputAction.next:
            onNextAction?.call();
            break;
          case TextInputAction.done:
            onDoneAction?.call();
            break;
          default:
            break;
        }
      },
    );
  }

  OutlineInputBorder getBorder(BuildContext context, TextFieldState type) {
    final Color borderColor;

    switch (type) {
      case TextFieldState.Disabled:
        borderColor = getColorScheme(context).colorPrimaryDisable;
        break;
      case TextFieldState.Focus:
        borderColor = getColorScheme(context).neutral100;
        break;
      case TextFieldState.Error:
        borderColor = getColorScheme(context).colorError;
        break;
      case TextFieldState.Default:
        borderColor = getColorScheme(context).neutral50;
        break;
      case TextFieldState.Complete:
        borderColor = getColorScheme(context).neutral50;
        break;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }

  Color getTextColor(BuildContext context, TextFieldState type) {
    Color textColor = getColorScheme(context).colorText;
    if (type == TextFieldState.Focus) {
      textColor = getColorScheme(context).colorText;
    } else if (type == TextFieldState.Error) {
      textColor = getColorScheme(context).colorText;
    } else if (type == TextFieldState.Default) {
      textColor = getColorScheme(context).neutral50;
    } else if (type == TextFieldState.Disabled) {
      textColor = getColorScheme(context).colorPrimaryDisable;
    } else if (type == TextFieldState.Complete) {
      textColor = getColorScheme(context).colorText;
    }
    return textColor;
  }
}
