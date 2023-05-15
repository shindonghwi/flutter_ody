import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/OrotApp.dart';
import 'package:odac_flutter_app/presentation/components/popup/widget/PopupAppPolicy.dart';

class PopupUtil {
  static void showAppPolicy({required bool backgroundTouchCloseFlag}) {
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          barrierDismissible: backgroundTouchCloseFlag, // 바깥 영역 터치시 닫을지 여부
          builder: (BuildContext context) {
            return const AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              content: PopUpAppPolicy(),
            );
          });
    });
  }

  static void close(){
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    Navigator.pop(context);
  }
}
