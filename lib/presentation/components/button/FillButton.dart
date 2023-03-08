import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class FillButton extends StatefulWidget {
  final double height;
  final Color? backgroundColor;
  final Widget child;
  final Function onTap;

  FillButton({
    Key? key,
    this.height = 56.0,
    this.backgroundColor,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FillButton> createState() => _FillButtonState();
}

class _FillButtonState extends State<FillButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQuery(context).size.width,
      height: widget.height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                if (widget.backgroundColor == null) {
                  return getColorScheme(context).primary.withOpacity(0.9);
                } else {
                  return widget.backgroundColor?.withOpacity(0.9);
                }
              } else if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              } else {
                if (widget.backgroundColor == null) {
                  return getColorScheme(context).primary;
                } else {
                  return widget.backgroundColor;
                }
              }
            },
          ),
        ),
        child: Center(child: widget.child),
        onPressed: () => widget.onTap(),
      ),
    );
  }
}
