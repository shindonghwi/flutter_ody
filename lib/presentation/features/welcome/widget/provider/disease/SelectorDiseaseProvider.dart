import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/model/SelectorDisease.dart';

class SelectorDiseaseProvider extends ChangeNotifier {
  List<SelectorDisease> _diseaseList = [];

  List<SelectorDisease> get diseaseList => _diseaseList;

  void setDiseaseList(List<String> diseaseNameList) {
    for (String diseaseName in diseaseNameList) {
      _diseaseList.add(SelectorDisease(
        diseaseName: diseaseName,
        isSelected: false,
      ));
    }
    notifyListeners();
  }

  void update(String disease) {
    int findIndex = _getFindIndex(disease);
    _diseaseList[findIndex].isSelected = !_diseaseList[findIndex].isSelected;
    notifyListeners();
  }

  bool isSelected(String disease) {
    int findIndex = _getFindIndex(disease);
    return _diseaseList[findIndex].isSelected;
  }

  int _getFindIndex(String disease) {
    int findIndex = _diseaseList.indexWhere(
      (element) {
        return element.diseaseName == disease;
      },
    );
    return findIndex;
  }
}
