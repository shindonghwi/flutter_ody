import 'package:flutter/material.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/presentation/components/popup/widget/PopupAppPolicy.dart';
import 'package:ody_flutter_app/presentation/components/popup/widget/PopupLogout.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class PopupUtil {
  static void showAppPolicy({required bool backgroundTouchCloseFlag}) {
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: backgroundTouchCloseFlag, // Whether to close when touching the outside area
        builder: (BuildContext context) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    content: const PopUpAppPolicy(),
                    backgroundColor: getColorScheme(context).white,
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }

  static void showLogout({required bool backgroundTouchCloseFlag}) {
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: backgroundTouchCloseFlag, // Whether to close when touching the outside area
        builder: (BuildContext context) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 100),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    content: const PopUpLogout(),
                    backgroundColor: getColorScheme(context).white,
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }

  static void close(){
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    Navigator.pop(context);
  }
}
