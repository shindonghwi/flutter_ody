import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/PatchMeDiseasesUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/PatchMeWeightUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final inputDiseaseUiStateProvider =
    StateNotifierProvider<InputDiseaseUiStateNotifier, UIState<String>>(
  (_) => InputDiseaseUiStateNotifier(),
);

class InputDiseaseUiStateNotifier extends StateNotifier<UIState<String>> {
  InputDiseaseUiStateNotifier() : super(Idle<String>());

  PatchMeDiseasesUseCase get _patchMeDiseaseUseCase =>
      GetIt.instance<PatchMeDiseasesUseCase>();

  void patchDisease(List<DiseaseType> diseaseList) {
    state = Loading();
    _patchMeDiseaseUseCase.call(diseases: diseaseList).then((value) {
      if (value.status == 200) {
        state = Success("");
      } else {
        state = Failure(value.message);
      }
    });
  }

  void resetState() => state = Idle();
}
