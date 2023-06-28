import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryForDaysUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
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
    if (state is Success) {
      final currentData = (state as Success<ResponseBioForDaysModel>).value;
      currentData.glucoses.add(glucoseData);
      state = Success(currentData);
    }
  }

  void addBpBioInfo(ResponseBioBloodPressureModel bpData) {
    if (state is Success) {
      final currentData = (state as Success<ResponseBioForDaysModel>).value;
      currentData.bloodPressures.add(bpData);
      state = Success(currentData);
    }
  }

  void init() {
    state = Idle();
  }
}
