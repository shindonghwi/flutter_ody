import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryForDaysUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:riverpod/riverpod.dart';

final forDaysBioInfoProvider = StateNotifierProvider<ForDaysBioInfoNotifier, UIState<ResponseBioForDaysModel?>>(
  (_) => ForDaysBioInfoNotifier(),
);

class ForDaysBioInfoNotifier extends StateNotifier<UIState<ResponseBioForDaysModel?>> {
  ForDaysBioInfoNotifier() : super(Idle());

  void requestBioInfo(int year, int month, int day) async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioHistoryForDaysUseCase>().call(year: year, month: month, day: day);
    if (res.status == 200) {
      Future.delayed(const Duration(milliseconds: 150), () => _updateBioInfo(res.data));
    } else {
      state = Failure(res.message);
    }
  }

  void _updateBioInfo(ResponseBioForDaysModel? data) {
    if (data != null) {
      state = Success(data);
    } else {
      state = Success(null);
    }
  }

  void addGlucoseBioInfo(ResponseBioGlucoseModel glucoseData) {
    debugPrint("addGlucoseBioInfo : $state");
    if (state is Success) {
      if (state is Success) {
        final currentData = (state as Success<ResponseBioForDaysModel>).value;
        final updatedList = CollectionUtil.isNullorEmpty(currentData.glucoses) ? [glucoseData] : [glucoseData, ...currentData.glucoses];
        state = Success(currentData.copyWith(
          steps: currentData.steps,
          bloodPressures: currentData.bloodPressures,
          glucoses: updatedList,
        ));
      }
    }
  }

  void addBpBioInfo(ResponseBioBloodPressureModel bpData) {
    debugPrint("addBpBioInfo : $state");
    if (state is Success) {
      if (state is Success) {
        final currentData = (state as Success<ResponseBioForDaysModel>).value;
        final updatedList = CollectionUtil.isNullorEmpty(currentData.bloodPressures) ? [bpData] : [bpData, ...currentData.bloodPressures];
        state = Success(currentData.copyWith(
          steps: currentData.steps,
          bloodPressures: updatedList,
          glucoses: currentData.glucoses,
        ));
      }
    }
  }

  void init() {
    state = Idle();
  }
}
