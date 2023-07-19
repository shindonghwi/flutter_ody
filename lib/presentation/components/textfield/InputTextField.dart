import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

enum InputFieldState { Default, Fill, Focus, Success, Error, Disable }

class InputTextField extends HookWidget {
  final String initText;
  final String hint;
  final String successMessage;
  final String errorMessage;
  final String fixedContent;

  final int maxLine;
  final int limit;

  final bool autoFocus;
  final bool enabled;
  final bool showCounter;
  final bool realTimeValidationCheck;

  final TextInputType textInputType;
  final TextInputAction textInputAction;

  final Function(String value)? onNextAction;
  final Function(String value)? onDoneAction;
  final Function(String value)? onChanged;

  final List<TextInputFormatter>? inputFormatters;
  final List<RegExp>? regList;

  const InputTextField({
    super.key,
    this.initText = '',
    this.hint = '',
    this.successMessage = '',
    this.errorMessage = '',
    this.fixedContent = '',
    this.maxLine = 1,
    this.limit = 10,
    this.autoFocus = false,
    this.enabled = true,
    this.showCounter = true,
    this.realTimeValidationCheck = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.regList = const [],
    this.onChanged,
    this.onNextAction,
    this.onDoneAction,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final currentType = useState(initTextFieldType(focusNode, initText));

    final contentValue = useState(initText);
    final controller = useTextEditingController(text: initText);

    final isFocused = useState(false);
    useEffect(() {
      void onFocusChanged() => isFocused.value = focusNode.hasFocus;
      focusNode.addListener(onFocusChanged);
      if (autoFocus) {
        Timer(const Duration(milliseconds: 300), () => focusNode.requestFocus());
        currentType.value = InputFieldState.Focus;
      }
      return () => focusNode.removeListener(onFocusChanged);
    }, [focusNode]);

    void checkRegExp() {
      if (regList == null || regList!.isEmpty) {
        currentType.value = InputFieldState.Success;
      } else {
        var isSuccess = false;
        var result = contentValue.value.replaceAll(fixedContent, "").trim();
        for (var element in regList!) {
          if (element.hasMatch(result)) {
            isSuccess = true;
            break;
          }
        }
        isSuccess ? currentType.value = InputFieldState.Success : currentType.value = InputFieldState.Error;
      }
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: getBackgroundColor(context, currentType.value),
            border: Border.all(
              color: getBorderColor(context, currentType.value),
              width: 1.5,
            ),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            autofocus: autoFocus,
            controller: controller,
            style: getTextTheme(context).l2m.copyWith(
                  color: getColorScheme(context).colorText,
                ),
            focusNode: focusNode,
            maxLines: maxLine,
            maxLength: limit,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: getTextTheme(context).l2m.copyWith(
                    color: getColorScheme(context).neutral50,
                  ),
              isCollapsed: true,
              suffixIcon: getSuffixIcon(context, currentType.value, contentValue.value),
              suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              counter: null,
              counterText: '',
            ),
            onChanged: (value) {
              final newValue = value.replaceAll(fixedContent, "");
              contentValue.value = newValue;
              if (realTimeValidationCheck) {
                checkRegExp();
              }
              onChanged?.call(newValue);
            },
            keyboardType: textInputType,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            onEditingComplete: () {
              var result = contentValue.value.trim();
              if (!realTimeValidationCheck) {
                checkRegExp();
              }
              switch (textInputAction) {
                case TextInputAction.next:
                  onNextAction?.call(result);
                  break;
                case TextInputAction.done:
                  onDoneAction?.call(result);
                  break;
                default:
                  break;
              }
              focusNode.unfocus();
            },
          ),
        ),
        if (currentType.value == InputFieldState.Error || currentType.value == InputFieldState.Success)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 18, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (successMessage.isNotEmpty && currentType.value == InputFieldState.Success)
                  Text(
                    successMessage,
                    style: getTextTheme(context).c2r.copyWith(
                          color: getHelpMessageColor(context, currentType.value),
                        ),
                  ),
                if (errorMessage.isNotEmpty && currentType.value == InputFieldState.Error)
                  Text(
                    errorMessage,
                    style: getTextTheme(context).c2r.copyWith(
                          color: getHelpMessageColor(context, currentType.value),
                        ),
                  ),
                if ((successMessage.isNotEmpty || errorMessage.isNotEmpty) && showCounter)
                  Text(
                    "${contentValue.value.replaceAll(fixedContent, "").length} / ${limit - fixedContent.length}",
                    style: getTextTheme(context).c1r.copyWith(
                          color: getHelpMessageColor(context, currentType.value),
                        ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  InputFieldState initTextFieldType(FocusNode focusNode, String content) {
    if (!enabled) {
      return InputFieldState.Disable;
    } else if (focusNode.hasFocus) {
      return InputFieldState.Focus;
    } else if (content.isNotEmpty) {
      return InputFieldState.Fill;
    }
    return InputFieldState.Default;
  }

  Color getBorderColor(BuildContext context, InputFieldState state) {
    switch (state) {
      case InputFieldState.Default:
        return getColorScheme(context).neutral50;
      case InputFieldState.Disable:
        return getColorScheme(context).neutral50;
      case InputFieldState.Fill:
        return getColorScheme(context).neutral50;

      case InputFieldState.Focus:
        return getColorScheme(context).colorPrimaryFocus;
      case InputFieldState.Success:
        return getColorScheme(context).colorPrimaryFocus;

      case InputFieldState.Error:
        return getColorScheme(context).colorError;
    }
  }

  Color getBackgroundColor(BuildContext context, InputFieldState state) {
    switch (state) {
      case InputFieldState.Disable:
        return getColorScheme(context).colorUI03;
      default:
        return getColorScheme(context).colorUI01;
    }
  }

  Color getHelpMessageColor(BuildContext context, InputFieldState state) {
    switch (state) {
      case InputFieldState.Focus:
      case InputFieldState.Success:
        return getColorScheme(context).colorPrimaryFocus;
      case InputFieldState.Error:
        return getColorScheme(context).colorError;
      default:
        return Colors.transparent;
    }
  }

  Widget getSuffixIcon(BuildContext context, InputFieldState state, String content) {
    if (content.isNotEmpty) {
      var iconPath = "";

      if (state == InputFieldState.Success) {
        iconPath = "assets/imgs/icon_small_check.png";
      } else if (state == InputFieldState.Error) {
        iconPath = "assets/imgs/icon_small_error.png";
      }
      if (iconPath.isNotEmpty){
        return Container(
          margin: const EdgeInsets.only(right: 16),
          child: Image.asset(
            iconPath,
            width: 20,
            height: 20,
          ),
        );
      }
    }
    return const SizedBox(
      width: 20,
      height: 20,
    );
  }
}
