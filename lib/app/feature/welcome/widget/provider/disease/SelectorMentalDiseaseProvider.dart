import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/provider/disease/SelectorDiseaseProvider.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

class SelectorMentalDiseaseProvider extends SelectorDiseaseProvider {
  SelectorMentalDiseaseProvider(BuildContext context) {
    List<String> diseaseNameList =
        getApplocalizations(context).welcome_mental_disease_items.split(",");
    setDiseaseList(diseaseNameList);
  }
}
