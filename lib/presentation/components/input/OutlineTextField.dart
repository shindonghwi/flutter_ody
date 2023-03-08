import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OutlineTextField extends HookWidget {
  final labelText;
  final hintText;
  final defaultText;
  final counterText;
  final keyboardType;
  final keyboardAction;
  final maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? actionCallback;
  final Function(String text)? textCallback;

  OutlineTextField({
    Key? key,
    this.labelText = "",
    this.hintText = "",
    this.counterText = "",
    this.defaultText = "",
    this.maxLength = 1000,
    this.keyboardType = TextInputType.text,
    this.keyboardAction = TextInputAction.done,
    this.inputFormatters,
    this.actionCallback,
    this.textCallback,
  }) : super(key: key);

  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    double contentVerticalPadding = 16.0;
    double borderRadius = 12.0;
    double borderWidth = 1.0;

    _controller = useState(TextEditingController()..text = defaultText).value;
    useEffect(() {
      return () {
        _controller.dispose();
      };
    }, const []);

    return TextField(
      maxLength: this.maxLength,
      controller: _controller,
      style: getTextTheme(context).titleMedium?.copyWith(
            color: getColorScheme(context).onBackground,
          ),
      textAlign: TextAlign.center,
      inputFormatters: this.inputFormatters,
      decoration: InputDecoration(
        labelText: this.labelText,
        hintText: this.hintText,
        hintStyle: getTextTheme(context).titleMedium?.copyWith(
              color: getColorScheme(context).onBackground.withOpacity(0.3),
            ),
        labelStyle: getTextTheme(context).bodyLarge?.copyWith(
              color: getColorScheme(context).onBackground,
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            width: borderWidth,
            color: getColorScheme(context).primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            width: borderWidth,
            color: getColorScheme(context).primary,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            width: borderWidth,
            color: getColorScheme(context).outline,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            width: borderWidth,
            color: getColorScheme(context).primary,
          ),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(contentVerticalPadding),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: this.counterText,
      ),
      textInputAction: keyboardAction,
      keyboardType: keyboardType,
      onChanged: (text) {
        if (textCallback != null) {
          textCallback!(text);
        }
      },
      onEditingComplete: () {
        if (actionCallback != null) {
          actionCallback!();
        }
      },
    );
  }
}
