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

final medicineScreenModeProvider =
    StateNotifierProvider<MedicineScreenModeNotifier, bool>(
  (_) => MedicineScreenModeNotifier(),
);

class MedicineScreenModeNotifier extends StateNotifier<bool> {
  MedicineScreenModeNotifier() : super(false);

  void changeMode(bool flag) async {
    state = flag;
  }
}
