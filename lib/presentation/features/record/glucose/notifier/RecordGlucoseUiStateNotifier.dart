import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/PostBioBloodPressureUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/PostBioGlucoseUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final recordGlucoseUiStateProvider =
    StateNotifierProvider<RecordGlucoseUiStateNotifier, UIState<String?>>(
  (_) => RecordGlucoseUiStateNotifier(),
);

class RecordGlucoseUiStateNotifier extends StateNotifier<UIState<String?>> {
  RecordGlucoseUiStateNotifier() : super(Idle<String?>());

  PostBioGlucoseUseCase get _postBioGlucoseUseCase =>
      GetIt.instance<PostBioGlucoseUseCase>();

  void postGlucose({
    required DateTime time,
    required GlucoseMeasureType type,
    required int glucose,
    String? memo,
    int? remindTime,
  }) async {
    state = Loading();

    final res = await _postBioGlucoseUseCase.call(
      time: time,
      type: type,
      glucose: glucose,
      memo: memo,
      remindTime: remindTime,
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
