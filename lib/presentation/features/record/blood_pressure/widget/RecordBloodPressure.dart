import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

import 'RecordBloodPressureInput.dart';
import 'RecordBloodPressureRange.dart';

class RecordBloodPressure extends HookWidget {
  const RecordBloodPressure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      padding: const EdgeInsets.only(left: 20, top: 22, bottom: 18, right: 13),
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Column(
        children: [
          RecordBloodPressureInput(),
          RecordBloodPressureRange(),
        ],
      ),
    );
  }
}
