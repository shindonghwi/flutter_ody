import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/InputProfileTextFieldNotifier.dart';

final inputProfileBirthdayTextFieldProvider =
    StateNotifierProvider<InputProfileBirthdayTextFieldNotifier, TextFieldModel>(
  (_) => InputProfileBirthdayTextFieldNotifier(),
);

class InputProfileBirthdayTextFieldNotifier extends InputProfileTextFieldNotifier {
  InputProfileBirthdayTextFieldNotifier() : super();

  @override
  RegExp get regex => RegExp(r"^\d{4}/\d{2}/\d{2}$");

  void updateBirthday(String newInput) => content = newInput;

  bool checkBirthday() => regex.hasMatch(content);
}
