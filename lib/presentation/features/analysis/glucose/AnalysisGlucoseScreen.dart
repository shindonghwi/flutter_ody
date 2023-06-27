import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/AverageGlucose.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/GlucoseFigure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/GlucoseRecordAnalysis.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class AnalysisGlucoseScreen extends StatelessWidget {
  const AnalysisGlucoseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).analysis_blood_pressure_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 24, 40, 64),
          child: Column(
            children: const [
              AverageGlucose(),

              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),

              GlucoseRecordAnalysis(),

              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),

              GlucoseFigure(),
              //
              // DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              //
              // HeartRateFigure()

            ],
          ),
        ),
      ),
    );
  }
}
