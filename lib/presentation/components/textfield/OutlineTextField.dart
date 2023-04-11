import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/BorderType.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OutlineTextField extends HookConsumerWidget {
  final String hint;
  final double borderRadius;
  final int maxLine;
  final int limit;
  final bool enabled;
  final ValueNotifier<String>? errorText;
  final Function(String value)? onChanged;
  final List<TextInputFormatter> inputFormatters;

  const OutlineTextField({
    Key? key,
    this.borderRadius = 8.0,
    this.hint = '',
    this.limit = 10,
    this.maxLine = 10,
    this.enabled = true,
    this.errorText = null,
    this.onChanged = null,
    this.inputFormatters = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TextInputFormatter> formatters = [...inputFormatters];
    formatters.add(LengthLimitingTextInputFormatter(limit));

    final focusNode = useFocusNode();
    final _isFocused = useState(false);
    useEffect(() {
      focusNode.addListener(() => _isFocused.value = focusNode.hasFocus);
    }, [focusNode]);

    return TextFormField(
      keyboardType: TextInputType.datetime,
      inputFormatters: formatters,
      initialValue: '',
      maxLength: limit,
      maxLines: maxLine,
      decoration: InputDecoration(
        filled: true,
        enabled: enabled,
        fillColor: Theme.of(context).colorScheme.colorUI01,
        errorMaxLines: maxLine,
        errorText: errorText?.value.isEmpty == true ? null : errorText?.value,
        border: getBorder(context, BorderType.Default),
        enabledBorder: getBorder(context, BorderType.Error),
        focusedBorder: getBorder(context, BorderType.Focused),
        focusedErrorBorder: getBorder(context, BorderType.Error),
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
      style: getTextTheme(context).l2.copyWith(
          color: _isFocused.value
              ? getTextColor(context, BorderType.Error)
              : getTextColor(context, BorderType.Default)),
      onChanged: (value) {
        onChanged?.call(value);
      },
      onTap: () => _isFocused.value = true,
      onFieldSubmitted: (value) => _isFocused.value = false,
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
