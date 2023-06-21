import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/app/OrotApp.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/GetMeMedicinesUseCase.dart';
import 'package:odac_flutter_app/presentation/features/cache/UserCache.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:riverpod/riverpod.dart';

final medicineListProvider =
    StateNotifierProvider<MedicineListNotifier, UIState<List<ResponseMeMedicineModel>?>>(
  (_) => MedicineListNotifier(),
);

class MedicineListNotifier extends StateNotifier<UIState<List<ResponseMeMedicineModel>?>> {
  MedicineListNotifier() : super(Idle());

  void requestMedicineList() async {
    state = Loading();
    final res = await GetIt.instance.get<GetMeMedicinesUseCase>().call();
    if (res.status == 200) {
      _updateMedicineList(res.list);
    }else{
      state = Failure(res.message);
    }
  }

  void _updateMedicineList(List<ResponseMeMedicineModel>? data) {
    if (!CollectionUtil.isNullorEmpty(data)){
      state = Success(data);
    }else{
      state = Success(null);
    }
  }
}
