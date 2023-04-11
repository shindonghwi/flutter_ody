import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OutlineTextField extends HookWidget {
  final String hint;
  final double borderRadius;
  final int maxLine;
  final int limit;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;

  const OutlineTextField({
    Key? key,
    this.borderRadius = 8.0,
    this.hint = '',
    this.limit = 10,
    this.maxLine = 10,
    this.enabled = true,
    this.inputFormatters = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();
    List<TextInputFormatter> formatters = [...inputFormatters];
    formatters.add(LengthLimitingTextInputFormatter(limit));

    final focusNode = useFocusNode();
    final _isFocused = useState(false);
    useEffect(() {
      focusNode.addListener(() => _isFocused.value = focusNode.hasFocus);
      return focusNode.dispose; // You need this return if you have missing_return lint
    }, [focusNode]);

    return TextField(
      controller: _textEditingController,
      keyboardType: TextInputType.datetime,
      inputFormatters: formatters,
      enabled: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: getColorScheme(context).colorUI01,
        border: getBorder(context, BorderType.Default),
        enabledBorder: getBorder(context, BorderType.Default),
        focusedBorder: getBorder(context, BorderType.Focused),
        errorBorder: getBorder(context, BorderType.Error),
        disabledBorder: getBorder(context, BorderType.Disabled),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
        hintText: hint,
        hintStyle: getTextTheme(context).l2.copyWith(
              color: getTextColor(context, BorderType.Disabled),
            ),
      ),
      focusNode: focusNode,
      style: getTextTheme(context).l2.copyWith(
          color: enabled
              ? _isFocused.value
                  ? getTextColor(context, BorderType.Error)
                  : getTextColor(context, BorderType.Default)
              : getTextColor(context, BorderType.Disabled)),
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
        borderColor = getColorScheme(context).neutral30;
        break;
      case BorderType.Disabled:
        borderColor = getColorScheme(context).colorPrimaryDisable;
        break;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(width: 1.5, color: borderColor),
    );
  }

  Color getTextColor(BuildContext context, BorderType type) {
    Color textColor = getColorScheme(context).colorText;
    if (type == BorderType.Focused) {
      textColor = getColorScheme(context).colorText;
    } else if (type == BorderType.Error) {
      textColor = getColorScheme(context).colorText;
    } else if (type == BorderType.Default) {
      textColor = getColorScheme(context).neutral30;
    } else if (type == BorderType.Disabled) {
      textColor = getColorScheme(context).colorPrimaryDisable;
    }
    return textColor;
  }
}

enum BorderType {
  Focused,
  Error,
  Default,
  Disabled,
}
