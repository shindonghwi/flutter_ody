import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/widget/RecordBloodPressure.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/widget/RecordBloodPressureAppBar.dart';
import 'package:odac_flutter_app/presentation/features/record/widget/RecordDateSelector.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordBloodPressureScreen extends HookWidget {
  const RecordBloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI03,
      appBar: const RecordBloodPressureAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            RecordDateSelector(),
            RecordBloodPressure(),
          ],
        ),
      ),
    );
  }
}
