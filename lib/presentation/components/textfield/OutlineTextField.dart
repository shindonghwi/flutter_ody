import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/BorderType.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';



class OutlineTextField extends HookWidget {
  final TextEditingController controller;
  final String hint;
  final double borderRadius;
  final int maxLine;
  final int limit;
  final bool enabled;
  final bool autoFocus;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextFieldState fieldState;
  final String? helpText;
  final VoidCallback? onNextAction;
  final VoidCallback? onDoneAction;
  final Function(String value)? onChanged;
  final List<TextInputFormatter> inputFormatters;

  const OutlineTextField({
    Key? key,
    this.borderRadius = 8.0,
    this.hint = '',
    this.limit = 10,
    this.maxLine = 1,
    this.enabled = true,
    this.autoFocus = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.helpText = null,
    this.onChanged = null,
    this.onNextAction = null,
    this.onDoneAction = null,
    this.inputFormatters = const [],
    required this.fieldState,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
        fillColor: Theme.of(context).colorScheme.colorUI01,
        errorMaxLines: maxLine,
        errorText:
            helpText?.isEmpty == true || fieldState == TextFieldState.Default ? null : helpText,
        errorStyle: getTextTheme(context).c2r.copyWith(
              color: fieldState == TextFieldState.Error
                  ? getColorScheme(context).colorError
                  : getColorScheme(context).colorPrimaryFocus,
            ),
        counterText: "",
        border: getBorder(context, BorderType.Default),
        enabledBorder: getBorder(context, BorderType.Default),
        focusedBorder: getBorder(context, BorderType.Focused),
        focusedErrorBorder: getBorder(
            context, fieldState == TextFieldState.Error ? BorderType.Error : BorderType.Focused),
        errorBorder: getBorder(
            context, fieldState == TextFieldState.Error ? BorderType.Error : BorderType.Focused),
        disabledBorder: getBorder(context, BorderType.Disabled),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
        hintText: hint,
        hintStyle: getTextTheme(context).l2m.copyWith(
              color: getTextColor(context, BorderType.Disabled),
            ),
      ),
      style: getTextTheme(context).l2m.copyWith(
          color: _isFocused.value
              ? getTextColor(context, BorderType.Error)
              : getTextColor(context, BorderType.Default)),
      onChanged: (value) {
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

  OutlineInputBorder getBorder(BuildContext context, BorderType type) {
    final Color borderColor;

    switch (type) {
      case BorderType.Focused:
        borderColor = getColorScheme(context).colorPrimaryFocus;
        break;
      case BorderType.Error:
        borderColor = getColorScheme(context).colorError;
        break;
      case BorderType.Default:
        borderColor = getColorScheme(context).neutral50;
        break;
      case BorderType.Disabled:
        borderColor = getColorScheme(context).colorPrimaryDisable;
        break;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }

  Color getTextColor(BuildContext context, BorderType type) {
    Color textColor = getColorScheme(context).colorText;
    if (type == BorderType.Focused) {
      textColor = getColorScheme(context).colorText;
    } else if (type == BorderType.Error) {
      textColor = getColorScheme(context).colorText;
    } else if (type == BorderType.Default) {
      textColor = getColorScheme(context).neutral50;
    } else if (type == BorderType.Disabled) {
      textColor = getColorScheme(context).colorPrimaryDisable;
    }
    return textColor;
  }
}
