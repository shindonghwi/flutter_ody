import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeHeightUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeNicknameUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeWeightUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final patchMeInfoUiStateProvider =
StateNotifierProvider<PatchMeInfoUiStateNotifier, UIState<String?>>(
      (_) => PatchMeInfoUiStateNotifier(),
);

class PatchMeInfoUiStateNotifier extends StateNotifier<UIState<String?>> {
  PatchMeInfoUiStateNotifier() : super(Idle<String?>());

  PatchMeHeightUseCase get _patchMeHeightUseCase => GetIt.instance<PatchMeHeightUseCase>();
  PatchMeWeightUseCase get _patchMeWeightUseCase => GetIt.instance<PatchMeWeightUseCase>();
  PatchMeNicknameUseCase get _patchMeNicknameUseCase => GetIt.instance<PatchMeNicknameUseCase>();

  void init(){
    state = Idle();
  }

  void patchHeight(int height) async {
    state = Loading();
    final res = await _patchMeHeightUseCase.call(height: height);

    if (res.status == 200){
      state = Success("");
    } else {
      state = Failure(res.message);
    }
  }

  void patchWeight(int weight) async {
    state = Loading();
    final res = await _patchMeWeightUseCase.call(weight: weight);

    if (res.status == 200){
      state = Success("");
    } else {
      state = Failure(res.message);
    }
  }

  void patchNickname(String nick) async {
    state = Loading();
    final res = await _patchMeNicknameUseCase.call(nick: nick);

    if (res.status == 200){
      state = Success("");
    } else {
      state = Failure(res.message);
    }
  }
}
