import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/me/ResponseProfileModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeGenderUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final inputGenderUiStateProvider =
    StateNotifierProvider<InputGenderUiStateNotifier, UIState<String>>(
  (_) => InputGenderUiStateNotifier(),
);

class InputGenderUiStateNotifier extends StateNotifier<UIState<String>> {
  InputGenderUiStateNotifier() : super(Idle<String>());

  PatchMeGenderUseCase get _patchMeGenderUseCase => GetIt.instance<PatchMeGenderUseCase>();

  void patchGender(GenderType type){
      state = Loading();
      _patchMeGenderUseCase.call(type: type).then((value) {
        if (value.status == 200) {
          state = Success("");
        } else {
          state = Failure(value.message);
        }
      });
  }

  void resetState() => state = Idle();

}
