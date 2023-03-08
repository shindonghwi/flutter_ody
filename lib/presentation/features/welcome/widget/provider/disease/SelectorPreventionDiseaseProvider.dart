import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/provider/disease/SelectorDiseaseProvider.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SelectorPreventionDiseaseProvider extends SelectorDiseaseProvider {
  SelectorPreventionDiseaseProvider(BuildContext context) {
    List<String> diseaseNameList =
        getApplocalizations(context).welcome_prevention_disease_items.split(",");
    setDiseaseList(diseaseNameList);
  }
}
