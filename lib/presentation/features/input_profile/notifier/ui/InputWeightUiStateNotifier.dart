import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeWeightUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final inputWeightUiStateProvider = StateNotifierProvider<InputWeightUiStateNotifier, UIState<String>>(
  (_) => InputWeightUiStateNotifier(),
);

class InputWeightUiStateNotifier extends StateNotifier<UIState<String>> {
  InputWeightUiStateNotifier() : super(Idle<String>());

  var weight = 0;

  void updateWeight(int value) => weight = value;

  PatchMeWeightUseCase get _patchMeWeightUseCase => GetIt.instance<PatchMeWeightUseCase>();

  void patchWeight() {
    state = Loading();
    _patchMeWeightUseCase.call(weight: weight).then((value) {
      if (value.status == 200) {
        state = Success("");
      } else {
        state = Failure(value.message);
      }
    });
  }

  void resetState() => state = Idle();

  void clearData() => weight = 0;
}
