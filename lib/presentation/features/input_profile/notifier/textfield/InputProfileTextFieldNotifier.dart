import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';

abstract class InputProfileTextFieldNotifier extends StateNotifier<TextFieldModel> {
  InputProfileTextFieldNotifier() : super(TextFieldModel(TextFieldState.Default, ''));

  String content = "";
  RegExp regex = RegExp(r'^(12[0-9]|1[3-9][0-9]|2[0-2][0-9]|230)$');

  void change({
    TextFieldState? fieldState,
    String? helpMessage,
  }) {
    state = TextFieldModel(
      fieldState ?? state.fieldState,
      helpMessage ?? state.helpMessage,
    );
  }

  clear() {
    content = "";
    Future<void>.delayed(
      Duration.zero,
      () => state = TextFieldModel(TextFieldState.Default, ''),
    );
  }
}
