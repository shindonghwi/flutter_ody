import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/provider/disease/SelectorDiseaseProvider.dart';

class SelectorMentalDiseaseProvider extends SelectorDiseaseProvider {
  SelectorMentalDiseaseProvider(BuildContext context) {
    List<String> diseaseNameList =
        getApplocalizations(context).welcome_mental_disease_items.split(",");
    setDiseaseList(diseaseNameList);
  }
}
