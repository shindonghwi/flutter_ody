import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/textfield/InputProfileTextFieldNotifier.dart';

final inputProfileWeightTextFieldProvider =
    StateNotifierProvider<InputProfileWeightTextFieldNotifier, TextFieldModel>(
  (_) => InputProfileWeightTextFieldNotifier(),
);

class InputProfileWeightTextFieldNotifier extends InputProfileTextFieldNotifier {
  InputProfileWeightTextFieldNotifier() : super();

  @override
  RegExp get regex => RegExp(r'^(30|[3-9][0-9]|1[0-9]{2}|200)$');

  void updateWeight(String newInput) => content = newInput;

  bool checkWeight() => regex.hasMatch(content);
}
