import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';

abstract class InputProfileTextFieldNotifier extends StateNotifier<TextFieldModel> {
  InputProfileTextFieldNotifier() : super(TextFieldModel(TextFieldState.Default, ''));

  void change({TextFieldState? fieldState = null, String? helpMessage = null}) {
    state = TextFieldModel(
      fieldState == null ? state.fieldState : fieldState,
      helpMessage == null ? state.helpMessage : helpMessage,
    );
  }

  clear() => Future<void>.delayed(
          Duration.zero,
          () => state = TextFieldModel(TextFieldState.Default, ''),
        );
}
