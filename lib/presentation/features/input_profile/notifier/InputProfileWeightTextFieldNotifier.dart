import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';

class InputProfileWeightTextFieldNotifier extends StateNotifier<TextFieldModel> {
  InputProfileWeightTextFieldNotifier() : super(TextFieldModel(TextFieldState.Default, ''));

  void change({TextFieldState? fieldState = null, String? helpMessage = null}) {
    state = TextFieldModel(
      fieldState == null ? state.fieldState : fieldState,
      helpMessage == null ? state.helpMessage : helpMessage,
    );
  }
}
