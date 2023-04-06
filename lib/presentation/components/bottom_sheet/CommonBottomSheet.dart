import 'package:flutter/material.dart';

class CommonBottomSheet {
  static showBottomSheet(
    BuildContext context, {
    double borderRadius = 20.0,
    Color backgroundColor = Colors.white,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (BuildContext context) {
        return BottomSheetWidget(
          child: child,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
        );
      },
    );
  }

  static close(BuildContext context, {Function? closeAction = null}) {
    Navigator.of(context).pop();
    closeAction?.call();
  }
}

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;

  const BottomSheetWidget({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
