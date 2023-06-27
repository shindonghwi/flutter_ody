import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/AverageBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/BpFigure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/BpRecordAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/HeartRateFigure.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class AnalysisBloodPressureScreen extends StatelessWidget {
  const AnalysisBloodPressureScreen({Key? key}) : super(key: key);

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
              AverageBloodPressure(),

              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),

              BpRecordAnalysis(),

              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),

              BpFigure(),

              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),

              HeartRateFigure()

            ],
          ),
        ),
      ),
    );
  }
}
