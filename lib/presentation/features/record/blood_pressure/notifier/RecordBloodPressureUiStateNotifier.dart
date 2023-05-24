import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/domain/usecases/remote/bio/PostBioBloodPressureUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final recordBloodPressureUiStateProvider =
    StateNotifierProvider<RecordBloodPressureUiStateNotifier, UIState<String?>>(
  (_) => RecordBloodPressureUiStateNotifier(),
);

class RecordBloodPressureUiStateNotifier extends StateNotifier<UIState<String?>> {
  RecordBloodPressureUiStateNotifier() : super(Idle<String?>());

  PostBioBloodPressureUseCase get _postBioBloodPressureUseCase =>
      GetIt.instance<PostBioBloodPressureUseCase>();

  void postBp({
    required DateTime time,
    required int systolicBloodPressure,
    required int diastolicBloodPressure,
    required int heartRate,
  }) async {
    state = Loading();

    final res = await _postBioBloodPressureUseCase.call(
      time: time,
      systolicBloodPressure: systolicBloodPressure,
      diastolicBloodPressure: diastolicBloodPressure,
      heartRate: heartRate,
    );

    if (res.status == 200) {
      // 혈압 등록 성공
      state = Success(null);
    } else {
      // 혈압 등록 실패
      state = Failure(res.message);
    }
  }

  void resetState() => state = Idle();

}
