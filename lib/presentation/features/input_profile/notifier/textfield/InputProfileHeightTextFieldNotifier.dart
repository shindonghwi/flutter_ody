import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/textfield/InputProfileTextFieldNotifier.dart';

final inputProfileHeightTextFieldProvider =
    StateNotifierProvider<InputProfileHeightTextFieldNotifier, TextFieldModel>(
  (_) => InputProfileHeightTextFieldNotifier(),
);

class InputProfileHeightTextFieldNotifier extends InputProfileTextFieldNotifier {
  InputProfileHeightTextFieldNotifier() : super();

  @override
  RegExp get regex => RegExp(r'^(12[0-9]|1[3-9][0-9]|2[0-2][0-9]|230)$');

  void updateHeight(String newInput) => content = newInput;

  bool checkHeight() => regex.hasMatch(content);
}
