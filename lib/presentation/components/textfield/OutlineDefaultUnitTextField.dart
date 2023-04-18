import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

// OutlineDefaultUnitTextField(
// controller: useTextEditingController(),
// textInputType: TextInputType.datetime,
// textInputAction: TextInputAction.next,
// hint: getAppLocalizations(context).input_profile_height_hint,
// onChanged: (String value) {},
// limit: 5,
// fieldState: TextFieldState.Complete,
// unit: "cm",
// )

class OutlineDefaultUnitTextField extends HookWidget {
  final TextEditingController controller;
  final String hint;
  final String unit;
  final double borderRadius;
  final int limit;
  final bool enabled;
  final bool autoFocus;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextFieldState fieldState;
  final VoidCallback? onNextAction;
  final VoidCallback? onDoneAction;
  final Function(String value)? onChanged;
  final List<TextInputFormatter> inputFormatters;

  const OutlineDefaultUnitTextField({
    Key? key,
    this.borderRadius = 8.0,
    this.hint = '',
    this.limit = 10,
    this.enabled = true,
    this.autoFocus = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged = null,
    this.onNextAction = null,
    this.onDoneAction = null,
    this.inputFormatters = const [],
    required this.fieldState,
    required this.controller,
    required this.unit,
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
            color: fieldState == TextFieldState.Focus
                ? getColorScheme(context).neutral100
                : fieldState == TextFieldState.Complete
                    ? getColorScheme(context).neutral70
                    : getColorScheme(context).neutral50,
            width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: controller,
              keyboardType: textInputType,
              textInputAction: textInputAction,
              inputFormatters: formatters,
              focusNode: focusNode,
              maxLength: limit,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                enabled: enabled,
                fillColor:
                    enabled ? getColorScheme(context).colorUI01 : getColorScheme(context).neutral30,
                errorMaxLines: 1,
                errorText: null,
                counterText: "",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
                hintText: hint,
                hintStyle: getTextTheme(context).t2b.copyWith(
                      color: getColorScheme(context).neutral60,
                    ),
              ),
              style: getTextTheme(context).t2b.copyWith(
                    color: _isFocused.value
                        ? getColorScheme(context).colorText
                        : getColorScheme(context).neutral60,
                  ),
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
            ),
          ),
          SizedBox(width: 10),
          Text(
            unit,
            style: getTextTheme(context).l3m.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
          ),
        ],
      ),
    );
  }
}
