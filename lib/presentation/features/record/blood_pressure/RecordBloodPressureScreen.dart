import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

import '../widget/RecordDateSelector.dart';
import 'widget/RecordBloodPressure.dart';

class RecordBloodPressureScreen extends HookWidget {
  const RecordBloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI03,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: getAppLocalizations(context).record_blood_pressure,
        actionText: getAppLocalizations(context).common_save,
        actionTextColor: getColorScheme(context).neutral50,
        actionTextCallback: () {},
      ),
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
