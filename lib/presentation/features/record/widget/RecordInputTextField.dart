import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordInputTextField extends HookWidget {
  final TextInputType textInputType;
  final String hint;
  final TextInputAction textInputAction;
  final VoidCallback? onNextAction;
  final VoidCallback? onDoneAction;
  final int limit;
  final Function(String value)? onChanged;
  final bool autoFocus;
  final List<TextInputFormatter> inputFormatters;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;

  const RecordInputTextField({
    Key? key,
    this.hint = '',
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onNextAction = null,
    this.autoFocus = false,
    this.textStyle = null,
    this.hintTextStyle = null,
    this.limit = 3,
    this.onDoneAction = null,
    this.onChanged = null,
    this.inputFormatters = const [],
  }) : super(key: key);

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
      textAlign: TextAlign.center,
      controller: useTextEditingController(),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: formatters,
      focusNode: focusNode,
      maxLength: limit,
      decoration: InputDecoration(
        filled: true,
        enabled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        fillColor: getColorScheme(context).white,
        errorText: null,
        counterText: "",
        border: InputBorder.none,
        hintText: hint,
        hintStyle: hintTextStyle ?? getTextTheme(context).t2b.copyWith(
              color: getColorScheme(context).neutral60,
            ),
      ),
      style: textStyle ?? getTextTheme(context).t2b.copyWith(
            color: getColorScheme(context).colorText,
          ),
      onChanged: (value) {
        onChanged?.call(value);
      },
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
}
