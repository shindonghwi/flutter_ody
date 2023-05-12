import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/OrotApp.dart';
import 'package:odac_flutter_app/presentation/components/popup/widget/PopupAppPolicy.dart';

class PopupUtil {
  static void showAppPolicy() {
    final context = OdyGlobalVariable.naviagatorState.currentContext as BuildContext;
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
          builder: (BuildContext context) {
            return const AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: PopUpAppPolicy(),
            );
          });
    });
  }
}
