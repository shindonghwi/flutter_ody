import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseInput.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseRange.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordGlucose extends HookWidget {
  const RecordGlucose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      padding:  EdgeInsets.only(left: 20, top: 22, bottom: 21, right: 14),
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          RecordGlucoseInput(),
          RecordGlucoseRange(),
        ],
      ),
    );
  }
}
