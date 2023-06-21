import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseInput.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseRange.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordGlucose extends HookWidget {
  const RecordGlucose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16, left: 15, right: 15),
      padding:  const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: const [
          RecordGlucoseInput(),
          RecordGlucoseRange(),
        ],
      ),
    );
  }
}
