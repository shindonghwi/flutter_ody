import 'package:flutter/material.dart';

class CommonBottomSheet {
  static showBottomSheet(
    BuildContext context, {
    double borderRadius = 20.0,
    Color backgroundColor = Colors.white,
    required double height,
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
          height: height,
        );
      },
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double height;
  final Color backgroundColor;

  const BottomSheetWidget({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.height,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
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
