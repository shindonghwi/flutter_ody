import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/provider/disease/SelectorDiseaseProvider.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SelectorChronicDiseaseProvider extends SelectorDiseaseProvider {
  SelectorChronicDiseaseProvider(BuildContext context) {
    List<String> diseaseNameList =
        getApplocalizations(context).welcome_chronic_disease_items.split(",");
    setDiseaseList(diseaseNameList);
  }
}
