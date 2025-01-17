import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeBirthdayUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeGenderUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeHeightUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final inputHeightUiStateProvider =
    StateNotifierProvider<InputHeightUiStateNotifier, UIState<String>>(
  (_) => InputHeightUiStateNotifier(),
);

class InputHeightUiStateNotifier extends StateNotifier<UIState<String>> {
  InputHeightUiStateNotifier() : super(Idle<String>());

  PatchMeHeightUseCase get _patchMeHeightUseCase =>
      GetIt.instance<PatchMeHeightUseCase>();

  var height = 0;

  void updateHeight(int value) => height = value;

  void patchHeight() {
    state = Loading();
    _patchMeHeightUseCase.call(height: height).then((value) {
      if (value.status == 200) {
        state = Success("");
      } else {
        state = Failure(value.message);
      }
    });
  }

  void resetState() => state = Idle();

  void clearData() => height = 0;
}
