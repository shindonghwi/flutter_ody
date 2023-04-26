import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/widget/RecordGlucose.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseMemo.dart';
import 'package:odac_flutter_app/presentation/features/record/widget/RecordDateSelector.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseScreen extends StatelessWidget {
  const RecordGlucoseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI03,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: '혈당기록',
        actionText: '저장',
        actionTextCallback: () {},
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            RecordDateSelector(),
            RecordGlucose(),
            RecordGlucoseMemo(),
          ],
        ),
      ),
    );
  }
}
