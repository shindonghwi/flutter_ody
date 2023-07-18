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
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final inputBirthdayUiStateProvider =
    StateNotifierProvider<InputBirthdayUiStateNotifier, UIState<String>>(
  (_) => InputBirthdayUiStateNotifier(),
);

class InputBirthdayUiStateNotifier extends StateNotifier<UIState<String>> {
  InputBirthdayUiStateNotifier() : super(Idle<String>());

  var birthday = "";

  void updateBirthday(String value) => birthday = value;

  PatchMeBirthdayUseCase get _patchMeBirthdayUseCase =>
      GetIt.instance<PatchMeBirthdayUseCase>();

  void patchBirthday() {
    state = Loading();
    _patchMeBirthdayUseCase.call(birthday: birthday).then((value) {
      if (value.status == 200) {
        state = Success("");
      } else {
        state = Failure(value.message);
      }
    });
  }

  void resetState() => state = Idle();
}
