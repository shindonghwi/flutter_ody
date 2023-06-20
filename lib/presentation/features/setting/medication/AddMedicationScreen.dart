import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/widget/MedicationName.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/widget/MedicationTime.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/widget/MedicationYoil.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class AddMedicationScreen extends StatelessWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).black,
        ),
        title: getAppLocalizations(context).add_medication_title,
      ),
      body: Column(
        children: const [
          MedicationName(),
          SizedBox(height: 32),
          MedicationYoil(),
          SizedBox(height: 32),
          MedicationTime()
        ],
      ),
    );
  }
}
